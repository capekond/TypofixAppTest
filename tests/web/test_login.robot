*** Settings ***
Documentation     Login functionality test suite for Typofix application
Resource          ../resources/keywords/web_keywords.robot
Resource          ../resources/variables/web_variables.robot
Resource          ../resources/variables/environment.robot
Suite Setup       Open Browser To Typofix
Suite Teardown    Close Browser

*** Test Cases ***
User Can Login With Valid Credentials
    [Documentation]    Test successful login with valid username and password
    [Tags]    smoke    login    positive
    Input Username    validuser@typofix.org
    Input Password    ValidPassword123
    Click Login Button
    Verify Login Success

User Cannot Login With Invalid Credentials
    [Documentation]    Test login failure with invalid credentials
    [Tags]    login    negative
    Input Username    invaliduser@typofix.org
    Input Password    WrongPassword
    Click Login Button
    Verify Login Error Message

User Session Is Maintained
    [Documentation]    Test that user session persists after login
    [Tags]    smoke    login    session
    Input Username    validuser@typofix.org
    Input Password    ValidPassword123
    Click Login Button
    Verify Login Success
    Refresh Page
    Verify User Is Still Logged In

Login Page Elements Are Visible
    [Documentation]    Verify all login form elements are present
    [Tags]    smoke    login    ui
    Verify Username Field Is Visible
    Verify Password Field Is Visible
    Verify Login Button Is Visible
    Verify Forgot Password Link Is Visible