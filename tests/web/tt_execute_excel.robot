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
    #todo finalyze color coding in Excel if possible
    [Arguments]    ${link}    ${language}    ${before}    ${after}
    ${hyperlink}=    Get Hyperlink By Link Name    column_name=link    value=${link}
    ${real}=    Get Real Result     ${hyperlink}    ${language}
    ${real_nbspace} =     Format nbspace Character    ${real}
    ${test_result}    ${details}    Assert Custom Typofix    ${after}    ${real_nbspace}
    ${timestamp}=    Get Current Date
    Add Results to Excel    ${after}    ${TEST_NAME}    ${test_result}    ${real_nbspace}    ${details}    ${timestamp}
    Save Test Case Excel
