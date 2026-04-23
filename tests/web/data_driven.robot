*** Variables ***
${CSV_DELIMITER}    |
${DATA_FILE}        TestCases.xlsx
#${DATA_FILE}        TestCases.csv

*** Settings ***
Library    DataDriver    file=../resources/test_data/${DATA_FILE}    encoding=UTF8
...    dialect=UserDefined
...    delimiter=${CSV_DELIMITER}
...    lineterminator='\r\n'
Resource   ../resources/keywords/api.robot
Resource   ../resources/keywords/web.robot
Library    SeleniumLibrary
Suite Setup  Let Open Browser
Suite Teardown      Close All Browsers
Test Template     Simple compare fixed entry with expected result backup

*** Test Cases ***
Check correction

*** Keywords ***
Simple compare fixed entry with expected result backup
    [Documentation]    Basic test
    [Arguments]    ${language}    ${preference}    ${given}    ${expected}    ${fixes_count}
    Set Predefined Preference    ${preference}
    Login If Necessary
    Select Language    ${language}
    Select Reference Set    ${preference}
    Input Text for Corretion    input=${given}
    Correct Text For Correction By Click On Buttons    ${fixes_count}
    Element Text Should Be    locator=${INPUT_INNER}    expected=${expected}