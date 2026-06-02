"""
Playwright Browser Fixtures

Provides pytest fixtures for:
- Browser context setup and teardown
- Page creation with common configuration
- Credentials loading
"""

import os
import pytest
from pathlib import Path
from playwright.async_api import async_playwright


@pytest.fixture(scope="session")
def get_credentials():
    """
    Load credentials from environment variables or secret file.

    Returns:
        Dictionary with EMAIL and WEB_PASSWORD
    """
    # Try loading from environment first
    email = os.getenv('TYPOFIX_EMAIL')
    password = os.getenv('TYPOFIX_PASSWORD')

    # Fallback to reading from secret file if available
    if not email or not password:
        secret_file = Path(__file__).parent.parent / 'variables' / 'secret.robot'
        if secret_file.exists():
            with open(secret_file) as f:
                for line in f:
                    if line.startswith('${EMAIL}'):
                        email = line.split()[-1]
                    elif line.startswith('${WEB_PASSWORD}'):
                        password = line.split()[-1]

    return {
        'EMAIL': email or 'test@example.com',
        'WEB_PASSWORD': password or 'test_password'
    }


@pytest.fixture(scope="session")
async def browser():
    """
    Create and manage Playwright browser instance.

    Yields:
        Playwright browser object
    """
    async with async_playwright() as p:
        browser = await p.chromium.launch(headless=False)
        yield browser
        await browser.close()


@pytest.fixture
async def context(browser):
    """
    Create a new browser context for each test.

    Args:
        browser: Browser instance from browser fixture

    Yields:
        Browser context object
    """
    context = await browser.new_context(
        viewport={'width': 1280, 'height': 720},
        record_video_dir='results/videos',
        record_har_path='results/har'
    )
    yield context
    await context.close()


@pytest.fixture
async def page(context, get_credentials):
    """
    Create a new page for each test with common setup.

    Args:
        context: Browser context from context fixture
        get_credentials: Credentials fixture

    Yields:
        Page object
    """
    page = await context.new_page()
    
    # Store credentials in page context for easy access
    page.credentials = get_credentials
    
    # Set default timeout
    page.set_default_timeout(30000)
    page.set_default_navigation_timeout(30000)
    
    yield page
    
    await page.close()


@pytest.fixture
async def admin_page(page):
    """
    Create a page logged into the admin panel.

    Args:
        page: Page fixture

    Yields:
        Authenticated page object
    """
    await page.goto("https://typofix.slonline.sk/admin/")
    
    # Check if login is needed
    try:
        await page.wait_for_selector("//h1[contains(text(),'Log in')]", timeout=5000)
        # Perform login
        await page.fill("id:MemberLoginForm_LoginForm_Email", page.credentials['EMAIL'])
        await page.fill("id:MemberLoginForm_LoginForm_Password", page.credentials['WEB_PASSWORD'])
        await page.click("id:MemberLoginForm_LoginForm_action_doLogin")
        await page.wait_for_load_state("networkidle")
    except:
        # Already logged in or selector not found
        pass
    
    # Handle 2FA if needed
    try:
        await page.wait_for_selector("//button[contains(text(),'Verify to continue')]", timeout=3000)
        await page.click("//button[contains(text(),'Verify to continue')]")
        await page.fill("id:SudoModePassword", page.credentials['WEB_PASSWORD'])
        await page.click("//button[contains(text(),'Verify')]")
        await page.wait_for_load_state("networkidle")
    except:
        # 2FA not required
        pass
    
    yield page


@pytest.fixture
async def tested_page(page):
    """
    Create a page for the tested application.

    Args:
        page: Page fixture

    Yields:
        Page object on the tested application
    """
    await page.goto("https://www.typofix.org/application#testing")
    await page.wait_for_load_state("networkidle")
    yield page
