*** Settings ***
Library    SeleniumLibrary
Library    ./KeywordsTypofix.py
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
    ${element_exists2} =    Run Keyword And Return Status    Page Should Contain Element    //button[contains(text(),'Verify to continue')]
    IF    ${element_exists2}
        Wait Until Element Is Visible    //button[contains(text(),'Verify to continue')]
        Click Button    //button[contains(text(),'Verify to continue')]
        Input Text      id:SudoModePassword    ${WEB_PASSWORD}
        Click Button    //button[contains(text(),'Verify')]
    END

Admin Get All Text Replaces
    Go To    ${ADMIN_BASE_URL}/text-replace
    ${pgs_info}=    Get Text    ${ADMIM_PG_INFO}
    #TODO only one page limitation
    ${pgs}     Evaluate    "${pgs_info}".split(" ")[2]
    #TODO end
    ${pgs}    Set Variable    1
    FOR    ${i}    IN RANGE    0     ${pgs}
        ${rows}=    Get Element Count    ${ADMIN_TABLE_TEXT_REPLACE}
        FOR    ${a}    IN RANGE    0    ${rows}
            Wait Until Element Is Enabled   //td[@class='col-ID']
            @{ids}=      Get WebElements    //td[@class='col-ID']
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

