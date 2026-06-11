*** Settings ***
Library    String
Library    Collections
Resource   ../resources/keywords/web_admin_keywords.robot
Library    ../resources/keywords/KeywordsTypofix.py
Suite Setup  Admin Let Open Browser
Test Teardown    Save Test Case Excel
Suite Teardown      Close All Browsers

*** Test Cases ***
Load defined examples to test cases
    [Documentation]   Build excel test cases
    Admin Login If Necessary
    ${excel_list}=    Create New Excel List in Excel
    Go To    ${ADMIN_BASE_URL}/rules
    ${pgs_info}=    Get Text    ${ADMIM_PG_INFO}
    #TODO only one page limitation
    ${pgs}     Evaluate    "${pgs_info}".split(" ")[2]
    #TODO end
    ${pgs}    Set Variable    1
    FOR    ${i}    IN RANGE    0     ${pgs}
        ${rows}=    Get Element Count    ${ADMIN_TABLE_TEXT_REPLACE}
        #TODO not work for last row
        FOR    ${a}    IN RANGE    0    ${rows}
#        FOR    ${a}    IN RANGE    20    21
            Wait Until Element Is Enabled   //td[@class='col-ID']
            @{ids}=             Get WebElements    //td[@class='col-ID']
            @{descriptions}=    Get WebElements    //td[@class='col-Description']
            @{tags}=            Get WebElements    //td[@class='col-Category-getBreadcrumbs']
            @{names}=           Get WebElements    //td[@class='col-Name']
            @{langs}=           Get WebElements    //td[@class='col-LanguagesNice']
            ${id}=               Get Text    ${ids}[${a}]
            ${name}=             Get Text    ${names}[${a}]
            ${description}=      Get Text    ${descriptions}[${a}]
            ${tag}=              Get Text    ${tags}[${a}]
            ${langs_by_coma}=    Get Text    ${langs}[${a}]
            ${has_examples}    ${languages}   ${befores}    ${afters}    Get Link Detail      ${id}    ${langs_by_coma}
            IF    ${has_examples}
                Add New Test Cases To Excel
                ...     excel_list=${excel_list}
                ...     id=${id}
                ...     name=${name}
                ...     description=${description}
                ...     tag=${tag}
                ...     languages=${languages}
                ...     befores=${befores}
                ...     afters=${afters}
            ELSE
                Add Missing Examples To Excel
                ...     id=${id}
                ...     name=${name}
                ...     description=${description}
                ...     tag=${tag}
                ...     languages=${languages}
            END
        END
        Wait Until Element Is Visible    ${ADMIN_NEXT}
        Click Button    ${ADMIN_NEXT}
        Sleep    5s
    END

TEST long table
    [Documentation]   TESTING
    Admin Login If Necessary
    Go To    ${ADMIN_BASE_URL}/rules
    ${pgs_info}=    Get Text    ${ADMIM_PG_INFO}
    ${pgs}     Evaluate    "${pgs_info}".split(" ")[2]
    Typofix File Log     Pages count ${pgs}    ${True}
    FOR    ${i}    IN RANGE    0     ${pgs}
        Typofix File Log     ------Page: ${i}
        ${rows}=    Get Element Count    ${ADMIN_TABLE_TEXT_REPLACE}
        FOR    ${a}    IN RANGE    0    ${rows}
            @{ids}=             Get WebElements    //td[@class='col-ID']
            ${id}=               Get Text    ${ids}[${a}]
            Typofix File Log     ${id}
        END
        Move Next Page    50    //td[@class='col-ID']
    END

*** Keywords ***

Move Next Page
    [Arguments]    ${page_len}    ${element_to_check}
    ${next}=     Run Keyword And Return Status    Element Should Be Enabled    ${ADMIN_NEXT}
    Return From Keyword If     ${next} is ${False}
    Click Button    ${ADMIN_NEXT}
    Wait Until Element Is Visible    ${element_to_check}
    FOR    ${i}    IN RANGE    50
        ${cnt}=    Get Element Count    ${element_to_check}
        Exit For Loop If    ${cnt} == ${page_len}
        Sleep    0.2s
    END

Get Link Detail
    [Arguments]    ${click_id}     ${langs_by_coma}
    ${link}=    Get Detail Link    ${click_id}
    Go To    ${link}
    ${no_data}=     Run Keyword And Return Status    Page Should Contain Element     //td[text()="No items found"]
    ${languages}=     Typofix Split String    ${langs_by_coma}
    IF    ${no_data}
        Click Element    ${ADMIN_GO_BACK}
        RETURN    ${False}    ${languages}    None    None
    ELSE
        ${final_languages}     ${befores}    ${afters}    Get Examples Details    ${languages}
        Click Element    ${ADMIN_GO_BACK}
        RETURN    ${True}    ${final_languages}    ${befores}    ${afters}
    END

Get Examples Details
    [Arguments]    ${expected_languages}
    ${languages_names}=    Create List
    @{languages}=        Get WebElements    //p[contains(@id,'_Title')]
    FOR    ${language}    IN    @{languages}
        ${language}=    Get Text    ${language}
        Append To List	    ${languages_names}    ${language}
    END
    ${editables}=    Create List
    ${cnt_lines}=    Get length     ${languages}
    FOR    ${i}    IN RANGE     1    ${cnt_lines}*2+1
        Select Frame     (//iframe[contains(@id,'Form_LanguageExamples_GridFieldEditableColumns')])[${i}]
        ${txt_count}=    Get Element Count    //p
        ${txt_list}=    Create List
        FOR    ${ii}    IN RANGE    ${txt_count}
            ${txt1}=    Get Text    //p[${ii}+1]
            Append To List	    ${txt_list}    ${txt1}
        END
        Unselect Frame
        Append To List	    ${editables}    ${txt_list}
    END
    ${final_languages}    ${befores}    ${afters}    Build Before After For Languages    ${editables}    ${languages_names}    ${expected_languages}
    RETURN    ${final_languages}      ${befores}    ${afters}



