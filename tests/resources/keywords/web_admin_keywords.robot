*** Settings ***
Library    SeleniumLibrary
Library    ./KeywordsTypofix.py
Resource   ../variables/secret.robot

*** Variables ***
${TESTED_BASE_URL}   https://www.typofix.org/application#testing
${ADMIN_BASE_URL}    https://typofix.slonline.sk/admin/

# Homepage Locators for tested
${LANGUAGE}               id:language-select
${REFERENCE_SET}          id:preference-set-select
${INPUT_INNER}            //*[@role="textbox"]/p/span/span/span
${OUTPUT_INNER}            //*[@role="textbox"]
${TYPOFIX}                //*[@title="Run Typofix"]
${REPLACE}                xpath://button[text()='Replace']
${REPLACEMENTS}           class:replacements-item

# Homepage Locators for admin
${ADMIN_TABLE_TEXT_REPLACE}       //table[@class="table grid-field__table"]/tbody/tr
${ADMIN_GO_BACK}                  //*[@id="Form_ItemEditForm"]/div[1]/div[1]/a
${ADMIN_BEFORE_TEXT_REPLACE}      xpath://textarea[@name='ExampleBefore']
${ADMIN_AFTER_TEXT_REPLACE}       xpath://textarea[@name='ExampleAfter']
${ADMIN_NEXT}                     xpath://button[@title='Next']
${ADMIM_PG_INFO}                  xpath://span[@class='pagination-page-number']

*** Keywords ***

Admin Let Open Browser
    [Documentation]    Opens a browser and provide email password to login
#     headlesschrome
    Typofix File Log    is_new=${True}
    Open Browser    ${ADMIN_BASE_URL}    headlesschrome
    Maximize Browser Window

Admin Login If Necessary
    [Documentation]    Opens a browser and provide email password to login
    Reload Page
    ${element_exists} =    Run Keyword And Return Status    Page Should Contain Element    //h2[contains(text(),'Log in')]
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