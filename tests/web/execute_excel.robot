*** Settings ***
Library    DataDriver    file=../resources/test_data/TestCases.xlsx    encoding=UTF8
Library    SeleniumLibrary
Library    DateTime
Library    ../resources/keywords/KeywordsTypofix.py
Resource   ../resources/keywords/web_admin_keywords.robot
Resource   ../resources/keywords/keywords.robot
Suite Setup  Admin Let Open Browser
Suite Teardown      Close All Browsers
Test Template     Exectute Test from Excel File

*** Test Cases ***
Execute test New version

*** Keywords ***
Exectute Test from Excel File
    [Arguments]    ${link}    ${language}    ${before}    ${after}
    ${hyperlink}=    Get Hyperlink By Link Name    column_name=link    value=${link}
    ${REAL}=    Get Real Result     ${hyperlink}    ${language}
    ${REAL_NBSPACE} =     Format nbspace Character    ${REAL}
    ${TEST_RESULT}    ${details}    Assert Custom Typofix    ${after}    ${REAL_NBSPACE}
    ${timestamp}=    Get Current Date
    Add Results to Excel    ${TEST_NAME}    ${TEST_RESULT}    ${REAL_NBSPACE}    ${details}    ${timestamp}
    Save Test Case Excel
