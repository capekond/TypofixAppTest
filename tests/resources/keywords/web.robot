*** Settings ***
Library    SeleniumLibrary
Library    ../keywords/KeywordsTypofix.py
Resource   ../variables/web.robot
Resource   ../variables/secret.robot

*** Keywords ***

Let Open Browser
    [Documentation]    Opens a browser and provide email password to login
    Open Browser    ${WEB_BASE_URL}    chrome
    Maximize Browser Window

Login If Necessary
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

Select Language
    [Arguments]    ${lang}
    Wait Until Element Is Visible      locator=${LANGUAGE}
    Wait Until Element Contains    locator=${LANGUAGE}    text=Select language    timeout=2s
    Click Element    ${LANGUAGE}
    Click Element    xpath://option[contains(text(), '${lang}')]

Select Reference Set
    [Arguments]    ${ref_set}
    Wait Until Element Is Visible    ${REFERENCE_SET}
    Click Element    ${REFERENCE_SET}
    TRY
        Click Element    xpath://option[contains(text(), '${ref_set}')]
    EXCEPT
        Click Element    xpath://option[contains(text()[2], '${ref_set}')]
    END

Input Text for Corretion
    [Arguments]    ${input}
    Input Text     ${INPUT_INNER_EMPTY}    ${input}
    Press Key      ${INPUT_INNER}    \\127

Correct Text For Correction By Click On Buttons
    [Arguments]    ${fixes_count}
    Click Element    ${TYPOFIX}
    Wait Until Element Is Visible    ${REPLACE}
    Page Should Contain Element    locator=${REPLACEMENTS}    limit=${fixes_count}
    TRY
        WHILE
            ${element}=    Get WebElement    ${REPLACE}
            Click Element    ${element}
        END
    EXCEPT
        Log To Console    Done, no more to correct
    END