*** Settings ***
Library    DataDriver    file=../resources/test_data/TestCases.xlsx    encoding=UTF8
Library    SeleniumLibrary
Library    DateTime
Library    ../resources/keywords/KeywordsTypofix.py
Resource   ../resources/keywords/web_admin_keywords.robot
Suite Setup  Admin Let Open Browser
Suite Teardown      Close All Browsers
Test Template     Exectute Test from Excel File

*** Test Cases ***
Execute test New version

*** Keywords ***
Exectute Test from Excel File
    [Arguments]    ${link}    ${language}    ${before}    ${after}
    Log        ${link} ${language} ${before} ${after}


#Exectute Test from Excel File
#    [Arguments]    ${link}    ${language}    ${before}    ${after}
#
#    ${hyperlink}=    Get Hyperlink By Link Name    column_name=link    value=${link}}
#    ${REAL}=    Get Real Result     ${hyperlink}    ${language}
#    ${TEST_RESULT}    ${DETAILS}    ${SCREENSHOT}    Assert Custom Typofix    ${after}    ${REAL}
#    ${TIMESTAMP}=    Get Current Date
#    Log    ${REAL} | ${hyperlink} | ${TEST_RESULT} | ${DETAILS} | ${SCREENSHOT} | ${TIMESTAMP}
#    Add Results to Excel    ${TEST_NAME}    ${TEST_RESULT}    ${REAL}    ${DETAILS}    ${TIMESTAMP}    ${SCREENSHOT}
#    Save Test Case Excel
#
#Get Real Result
#    [Arguments]     ${link}    ${language}
#    Admin Login If Necessary
#    Go To    ${link}
#    RETURN    dummy Real
#
#
#Assert Custom Typofix
#    [Arguments]    ${after}    ${real}
#    VAR    ${SCR}    dummy/http/picture
#    VAR    ${TR}     DUMMY_FAIL
#    VAR    ${DET}    '${after}' is not equal '${real}'
#    RETURN    ${TR}    ${DET}    ${SCR}