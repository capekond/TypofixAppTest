*** Variables ***
${DATA_FILE}        TestCases.xlsx

*** Settings ***
Library    DataDriver    file=../resources/test_data/${DATA_FILE}    encoding=UTF8
Resource    ../resources/keywords/api_tested_keywords.robot
Resource    ../resources/keywords/web_tested_keywords.robot
Library    SeleniumLibrary
Library    ../keywords/KeywordsTypofix.py

Suite Setup  Let Open Browser
Suite Teardown      Close All Browsers
Test Template     Change Excel Add Count of fixes for TCs

*** Test Cases ***
Add Count of fixes for TCs

*** Keywords ***
Change Excel Add Count of fixes for TCs
    [Documentation]    For excel file add expected fixes count
    [Arguments]    ${language}    ${given}    ${expected}    ${fixes_count}
    Login If Necessary
    Select Language    ${language}
    ${preference}=    Get Field For Language From Reference    language=${language}    field=name
    Select Reference Set    ${preference}
    Input Text for Corretion    input=${given}
    Add Count Fixes For Every TC    overwrite=True
