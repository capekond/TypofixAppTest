*** Settings ***
Library    DataDriver    ../resources/test_data/TestCases.xlsx    sheet_name=tc
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
    [Arguments]    ${language}    ${preference}    ${given}    ${expected}
    Login If Necessary
    Select Language    ${language}
    Select Reference Set    ${preference}
    Input Text for Corretion    input=${given}
    Correct Text For Correction By Click On Buttons
    Click Element    ${TYPOFIX}
    Element Text Should Be    locator=${INPUT_INNER}    expected=${expected}