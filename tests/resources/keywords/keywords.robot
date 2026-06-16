*** Settings ***
Library    SeleniumLibrary
Library    String
Library    Collections
Library    ./KeywordsTypofix.py
Resource   ../variables/secret.robot
Resource   ../resources/keywords/web_admin_keywords.robot

*** Keywords ***

Get Main Data
    [Documentation]   Get main Data to local data
    @{data}=    Create List
    Admin Login If Necessary
    Go To    ${ADMIN_BASE_URL}/rules
    ${pgs_info}=    Get Text    ${ADMIM_PG_INFO}
    ${pgs}     Evaluate    "${pgs_info}".split(" ")[2]
    # TODO                           ${pgs}
    FOR    ${i}    IN RANGE    0     ${pgs}
        ${rows}=    Get Element Count    ${ADMIN_TABLE_TEXT_REPLACE}
        # TODO                     0     ${rows}
        FOR    ${a}    IN RANGE     0    ${rows}
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
            @{data_item}=    Create List    ${id}    ${name}    ${description}    ${tag}    ${langs_by_coma}
            Append To List    ${data}    ${data_item}
        END
        Move Next Page    50    //td[@class='col-ID']
    END
    ${ids}    ${names}    ${descriptions}    ${tags}    ${expected_languages}     Get Columns From Data    ${data}
    RETURN    ${ids}    ${names}    ${descriptions}    ${tags}    ${expected_languages}

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
    [Arguments]    ${click_id}     ${expected_languages_per_id}
    ${has_examples}=     Check if Link Detail has examples    ${click_id}
    IF    ${has_examples}
         ${languages_examples}=    Create List
            @{languages_elements}=        Get WebElements    //p[contains(@id,'_Title')]
            FOR    ${language}    IN    @{languages_elements}
                ${language_example}=    Get Text    ${language}
                Append To List	    ${languages_examples}    ${language_example}
            END
            ${examples}=    Create List
            ${cnt_lines}=    Get length     ${languages_elements}
            FOR    ${i}    IN RANGE     1    ${cnt_lines}*2+1
                Select Frame     (//iframe[contains(@id,'Form_LanguageExamples_GridFieldEditableColumns')])[${i}]
                ${txt_count}=    Get Element Count    //p
                ${txt_list}=    Create List
                FOR    ${ii}    IN RANGE    ${txt_count}
                    ${txt1}=    Get Element Attribute    //p[${ii}+1]    textContent
                    Append To List	    ${txt_list}    ${txt1}
                END
                Unselect Frame
                Append To List	    ${examples}    ${txt_list}
            END
            ${final_languages}    ${before_examples}    ${after_examples}    Build Before After For Languages    ${examples}    ${languages_examples}    ${expected_languages_per_id}
            ${after_ex_nbspace}    Format nbspace Character    ${after_examples}
        RETURN    ${True}    ${final_languages}    ${before_examples}    ${after_ex_nbspace}
    ELSE
        RETURN    ${False}  None    None    None
    END

Check if Link Detail has examples
    [Arguments]    ${click_id}
    ${link}=    Get Detail Link    ${click_id}
    Go To    ${link}
    Wait Until Element Is Visible    //h2[text()="Language examples"]
    ${has_examples}=     Run Keyword And Return Status    Page Should Not Contain Element     //td[text()="No items found"]
    RETURN    ${has_examples}

Get Real Result
    [Arguments]     ${link}    ${language}
    Admin Login If Necessary
    Go To    ${link}
    Click Link    //a[text()='Examples']
    @{languages_elements}=        Get WebElements    //p[contains(@id,'_Title')]
    VAR    ${i}=    0
    FOR    ${language_element}    IN    @{languages_elements}
        ${i}=    Evaluate  ${i}+1
        ${language_example}=    Get Text    ${language_element}
        IF  "${language_example}" == "${language}"
            BREAK
        END
    END
    Log    ${i}
    @{real_emelent}=  Get WebElements    //pre[@class='ecma-validation__result']
    ${real}=   Get Text     ${real_emelent}[${i-1}]
    RETURN    ${real}