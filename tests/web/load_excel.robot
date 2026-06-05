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
            @{details}=          Get Link Detail      ${ids}[${a}]    ${langs_by_coma}
            Add New Test Cases To Excel
            ...     excel_list=${excel_list}
            ...     id=${id}
            ...     name=${name}
            ...     description=${description}
            ...     tag=${tag}
            ...     languages=${details}[1]
            ...     befores=${details}[2]
            ...     afters=${details}[3]
        END
        Wait Until Element Is Visible    ${ADMIN_NEXT}
        Click Button    ${ADMIN_NEXT}
        Sleep    5s
    END
    Save Test Case Excel

TEST Get Example Details
    Get Example Details     197



*** Keywords ***

Get Example Details
    [Arguments]    ${click_id}
    ${link}=    Get Detail Link    ${click_id}
    Go To    ${link}

    Admin Login If Necessary

    Click Link    //*[@id="ui-id-2"]

    Select Frame     //iframe[@id='Form_LanguageExamples_GridFieldEditableColumns_12_ExampleBefore_ifr']
    ${txt_count}=    Get Element Count    //p

    FOR    ${i}    IN RANGE    ${txt_count}
        ${txt}=    Get Text    //p[${i}+1]
        Log    ${txt}
    END


    ${befores}    Set Variable     Befores
    ${afters}     Set Variable     Afters
    RETURN    ${befores}    ${afters}


#Get Link Detail
#    [Arguments]    ${click_id}    ${langs_by_coma}
#    Click Element    ${click_id}
#    Wait Until Element Is Enabled     ${ADMIN_GO_BACK}
#    ${link}=     Get Location
#    @{before}=    Create List
#    @{after}=    Create List
#    @{languages}=    Split String     ${langs_by_coma}    separator=,
#    FOR    ${lang}        IN    @{languages}
#        Log    TODO the correct reading of details
#        Append To List        ${before}    Given for lang ${lang}
#        Append To List        ${after}     Expected for lang ${lang}
#    END
#    Click Element    ${ADMIN_GO_BACK}
#    RETURN    ${link}    ${languages}    ${before}    ${after}
