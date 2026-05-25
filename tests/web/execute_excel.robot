*** Variables ***
${DATA_FILE}        TestCases.xlsx

*** Settings ***
Library    DataDriver    file=../resources/test_data/${DATA_FILE}    encoding=UTF8
Resource    ../resources/keywords/api_tested_keywords.robot
Resource    ../resources/keywords/web_tested_keywords.robot
Library    SeleniumLibrary
Library    ../resources/keywords/KeywordsTypofix.py

Suite Setup  Let Open Browser
Suite Teardown      Close All Browsers
Test Template     Change Excel Add Count of fixes for TCs

*** Test Cases ***


*** Keywords ***


