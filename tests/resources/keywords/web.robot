*** Settings ***
Library    SeleniumLibrary
Library    ../keywords/KeywordsTypofix.py
Resource   ../variables/web_variables.robot
Resource   ../variables/environment.robot

*** Keywords ***
Open Browser And Login If Necessary
    [Documentation]    Opens a browser and provide email password to login
    Open Browser    ${WEB_BASE_URL}    chrome
    Maximize Browser Window
    ${element_exists} =    Run Keyword And Return Status    Page Should Contain Element    id=email
    IF    ${element_exists}
        Input Text      id:email    ${EMAIL}
        Input Text      id:password    ${WEB_PASSWORD}
        Click Button    xpath://button[@type='submit']
        Log To Console  Login, session created
    ELSE
        Log To Console  Reuse open session
    END

#Select Language
#    Wait Until Element Is Not Visible
#
#Select Reference Set
#    Wait Until Element Is Not Visible


