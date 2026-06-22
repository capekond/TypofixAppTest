*** Settings ***
Documentation     Example test cases using the data-driven testing approach.
Library    ../resources/keywords/KeywordsTypofix.py
Resource   ../resources/keywords/web_admin_keywords.robot
Resource   ../resources/keywords/keywords.robot
Suite Setup       Create New Excel List In Excel    ColorCell    ${False}
Suite Teardown    Save Test Case Excel
Test Template     Test Color Excel

*** Test Cases ***       after                    real
Tc1                      abcd                     abxcd
Tc2                      abcd                     xabxd
Tc3                      abcd                     abcd1
Tc3                      abcd                     abcd

*** Keywords ***
Test Color Excel
    [Arguments]       ${after}    ${real}
    Log    ${after} ${real}
    Add String To Excel    ${after}     ${real}
    Save Test Case Excel



