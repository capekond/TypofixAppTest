*** Variables ***
${DATA_FILE}        TestCases.xlsx

*** Settings ***
Library    DataDriver    file=../resources/test_data/${DATA_FILE}    encoding=UTF8
Library    SeleniumLibrary
Library    ../resources/keywords/KeywordsTypofix.py
Resource   ../resources/keywords/web_admin_keywords.robot
Suite Setup  Admin Let Open Browser
Suite Teardown      Close All Browsers
Test Template     Exectute Test from Excel File

*** Test Cases ***
Execute test

*** Keywords ***
Exectute Test from Excel File
    [Arguments]    ${link}    ${language}    ${before}    ${after}
    Log    ${link}
    Log    ${language}
    Log    ${before}
    Log    ${after}

