*** Settings ***
Library    DataDriver    ../resources/test_data/TestCases.xlsx    sheet_name=tc
#Library    DataDriver    TestCases.xlsx
Test Template     Demo Only

*** Test Cases ***
Check correction

*** Keywords ***
Demo Only
    [Arguments]    ${language}    ${preference}    ${given}    ${expected}
    Log To Console    ${language}
    Log To Console    ${preference}
    Log To Console    ${given}
    Log To Console    ${expected}