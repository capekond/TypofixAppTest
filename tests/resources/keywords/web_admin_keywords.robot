*** Settings ***
Library    SeleniumLibrary
Library    ../keywords/KeywordsTypofix.py
Resource   ../variables/web_tested_variables.robot
Resource   ../variables/api_tested_variables.robot
Resource   ../variables/secret.robot

*** Keywords ***

Admin Let Open Browser
    [Documentation]    Opens a browser and provide email password to login
    Open Browser    ${ADMIN_BASE_URL}    headlesschrome
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
    ${pgs_info}=    Get Text    ${ADMIM_PG_INFO}
    ${pgs}     Evaluate    "${pgs_info}".split(" ")[2]
    #TODO only one page limitation
    ${pgs}    Set Variable    1
    FOR    ${i}    IN RANGE    0     ${pgs}
        ${rows}=    Get Element Count    ${ADMIN_TABLE_TEXT_REPLACE}
        FOR    ${a}    IN RANGE    0    ${rows}
            Wait Until Element Is Enabled   //td[@class='col-ID']
            @{ids}=      Get WebElements      //td[@class='col-ID']
            @{names}=    Get WebElements    //td[@class='col-Name']
            @{langs}=    Get WebElements    //td[@class='col-LanguagesNice']
            ${id}=       Get Text    ${ids}[${a}]
            ${name}=     Get Text    ${names}[${a}]
            ${lang}=     Get Text    ${langs}[${a}]
            Data Store Add Item    id          ${id}
            Data Store Add Item    name        ${name}
            Data Store Add Item    languages   ${lang}
            Admin Get Test Replaces Details      ${ids}[${a}]
            Log To Console    ${id}
            Log To Console    ${name}
            Log To Console    ${lang}
        END
        Wait Until Element Is Visible    ${ADMIN_NEXT}
        Click Button    ${ADMIN_NEXT}
        Sleep    5s
    END

Admin Get Test Replaces Details
    [Arguments]    ${click_id}
    Click Element    ${click_id}
    Wait Until Element Is Enabled     ${ADMIN_GO_BACK}
    Wait Until Element Is Enabled     ${ADMIN_BEFORE_TEXT_REPLACE}
    ${txtBefore}=    Get Value        ${ADMIN_BEFORE_TEXT_REPLACE}
    ${txtAfter}=    Get Value        ${ADMIN_AFTER_TEXT_REPLACE}
    Data Store Add Item    text before    ${txtBefore}
    Data Store Add Item    text after     ${txtAfter}    new_line=True
    Click Element    ${ADMIN_GO_BACK}
