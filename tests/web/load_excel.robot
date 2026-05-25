*** Settings ***
Library    String
Library    Collections
Resource   ../resources/keywords/web_admin_keywords.robot
Library    ../resources/keywords/KeywordsTypofix.py
Suite Setup  Admin Let Open Browser
Suite Teardown      Close All Browsers

*** Test Cases ***
Load defined examples to test cases
    [Documentation]   Build excel test cases
    Admin Login If Necessary
    ${excel_list}=    Create New Excel List in Excel
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
            ${langs_by_coma}=     Get Text    ${langs}[${a}]
            @{details}=    Get Link Detail      ${ids}[${a}]    ${langs_by_coma}
            Add New Test Cases To Excel
            ...     excel_list=${excel_list}
            ...     id=${id}
            ...     name=${name}
            ...     url_detail=${details}[0]
            ...     languages=${details}[1]
            ...     befores=${details}[2]
            ...     afters=${details}[3]
        END
        Wait Until Element Is Visible    ${ADMIN_NEXT}
        Click Button    ${ADMIN_NEXT}
        Sleep    5s
    END

*** Keywords ***

Get Link Detail
    [Arguments]    ${click_id}    ${langs_by_coma}
    Click Element    ${click_id}
    Wait Until Element Is Enabled     ${ADMIN_GO_BACK}
    ${link}=     Get Location
    @{before}=    Create List
    @{after}=    Create List
    @{languages}=    Split String     ${langs_by_coma}    separator=,
    FOR    ${lang}        IN    @{languages}
        Log    TODO the correct reading of details
        Append To List        ${before}    Given for lang ${lang}
        Append To List        ${after}     Expected for lang ${lang}
    END
    Click Element    ${ADMIN_GO_BACK}
    RETURN    ${link}    ${languages}    ${before}    ${after}
