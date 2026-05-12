*** Settings ***
Library    SeleniumLibrary
Library    ../keywords/KeywordsTypofix.py
Resource   ../variables/web_tested_variables.robot
Resource   ../variables/api_tested_variables.robot
Resource   ../variables/secret.robot

*** Keywords ***

Admin Let Open Browser
    [Documentation]    Opens a browser and provide email password to login
    Open Browser    ${ADMIN_BASE_URL}    chrome
    Maximize Browser Window

Admin Login If Necessary
    [Documentation]    Opens a browser and provide email password to login
    Reload Page
    ${element_exists} =    Run Keyword And Return Status    Page Should Contain Element    id=email
    IF    ${element_exists}
        Input Text      id:email    ${EMAIL}
        Input Text      id:password    ${WEB_PASSWORD}
        Click Button    xpath://button[@type='submit']
        Log To Console  Login, session created
    ELSE
        Log To Console  Reuse open session
    END
