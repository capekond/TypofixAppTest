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
    ${element_exists} =    Run Keyword And Return Status    Page Should Contain Element    //h1[contains(text(),'Log in')]
    IF    ${element_exists}
        Input Text      id:MemberLoginForm_LoginForm_Email    ${EMAIL}
        Input Text      id:MemberLoginForm_LoginForm_Password    ${WEB_PASSWORD}
        Click Button    id:MemberLoginForm_LoginForm_action_doLogin
        Log To Console  Login, session created
    ELSE
        Log To Console  Reuse open session
    END
    Wait Until Element Is Visible    //button[contains(text(),'Verify to continue')]
    Click Button    //button[contains(text(),'Verify to continue')]
    Input Text      id:SudoModePassword    ${WEB_PASSWORD}
    Click Button    //button[contains(text(),'Verify')]

Admin Get All Text Replaces
    Go To    ${ADMIN_BASE_URL}/text-replace
    ${rows}=    Get Element Count    ${ADMIN_TABLE_TEXT_REPLACE}
    @{ids}=    Get WebElements    //td[@class='col-ID']
    @{names}=    Get WebElements    //td[@class='col-Name']
    @{langs}=    Get WebElements    //td[@class='col-LanguagesNice']
    FOR    ${a}    IN RANGE    0    ${rows}
        ${id}=       Get Text    ${ids}[${a}]
        Log To Console    ${id}
        ${name}=       Get Text    ${names}[${a}]
        Log To Console    ${name}
        ${lang}=       Get Text    ${langs}[${a}]
        Log To Console    ${lang}




    END