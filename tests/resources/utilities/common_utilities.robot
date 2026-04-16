*** Keywords ***
Log Test Information
    [Documentation]    Logs test execution information
    [Arguments]    ${message}
    Log    ${message}    INFO

Wait For Element And Click
    [Documentation]    Waits for element to be visible and clicks it
    [Arguments]    ${locator}    ${timeout}=10s
    Wait For Elements State    ${locator}    visible    timeout=${timeout}
    Click    ${locator}

Wait For Element And Type
    [Documentation]    Waits for element and types text
    [Arguments]    ${locator}    ${text}    ${timeout}=10s
    Wait For Elements State    ${locator}    visible    timeout=${timeout}
    Type Text    ${locator}    ${text}

Get Random String
    [Documentation]    Generates random string for test data
    [Arguments]    ${length}=10
    ${random}=    Evaluate    ''.join(__import__('random').choices(__import__('string').ascii_letters, k=${length}))
    RETURN    ${random}

Get Timestamp
    [Documentation]    Returns current timestamp
    ${timestamp}=    Evaluate    __import__('time').strftime('%Y%m%d%H%M%S')
    RETURN    ${timestamp}

Create Test Email
    [Documentation]    Creates unique test email address
    ${timestamp}=    Get Timestamp
    ${email}=    Evaluate    f'test{${timestamp}}@typofix.org'
    RETURN    ${email}

Verify Response Is Valid JSON
    [Documentation]    Verifies response is valid JSON
    [Arguments]    ${response}
    ${json}=    Evaluate    ${response.json()}
    Should Not Be Empty    ${json}

Compare Lists
    [Documentation]    Compares two lists for equality
    [Arguments]    ${list1}    ${list2}
    Lists Should Be Equal    ${list1}    ${list2}