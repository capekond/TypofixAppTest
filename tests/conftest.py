"""
Pytest Configuration and Fixtures

Configures pytest for Playwright tests and imports all fixtures.
"""

import pytest
from pathlib import Path
import sys

# Add resources directory to path for importing helpers and fixtures
resources_dir = Path(__file__).parent / 'resources'
sys.path.insert(0, str(resources_dir))

from fixtures.browser_fixtures import browser, context, page, admin_page, tested_page, get_credentials
from helpers.typofix_helpers import TypofixHelpers


def pytest_configure(config):
    """Configure pytest with custom markers and settings"""
    config.addinivalue_line("markers", "admin: mark test as admin panel test")
    config.addinivalue_line("markers", "load: mark test as data loading test")
    config.addinivalue_line("markers", "execute: mark test as test execution test")


@pytest.fixture(scope="session")
def typofix_helpers():
    """Provide TypofixHelpers instance for all tests"""
    return TypofixHelpers()


def pytest_collection_modifyitems(config, items):
    """Automatically add markers based on test location"""
    for item in items:
        if "load_excel" in item.nodeid:
            item.add_marker(pytest.mark.load)
        elif "execute_excel" in item.nodeid:
            item.add_marker(pytest.mark.execute)
