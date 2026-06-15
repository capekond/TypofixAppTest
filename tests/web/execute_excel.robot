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
#    Log        ${link}
    ${hyperlink}=    Get Hyperlink By Link Name    column_name=link    value=${link}
    ${REAL}=    Get Real Result     ${hyperlink}    ${language}
    ${TEST_RESULT}    ${details}    Assert Custom Typofix    ${after}    ${REAL}
    ${timestamp}=    Get Current Date
#    Log    ${REAL} | ${hyperlink} | ${TEST_RESULT} | ${details} | ${timestamp}
    Add Results to Excel    ${TEST_NAME}    ${TEST_RESULT}    ${REAL}    ${details}    ${timestamp}
    Save Test Case Excel