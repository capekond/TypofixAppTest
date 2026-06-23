*** Settings ***
Documentation     Example test cases using the data-driven testing approach.
Library    ../resources/keywords/KeywordsTypofix.py
Resource   ../resources/keywords/web_admin_keywords.robot
Resource   ../resources/keywords/keywords.robot
#Suite Setup       Create New Excel List In Excel    ColorCell    ${False}
#Suite Teardown    Save Test Case Excel
Test Template     Test Color Excel

*** Test Cases ***       after                    real        round
Tc1                      abcd                     abxcd       1
Tc2                      abcd                     xabxd       2
Tc3                      abcd                     abcd1       3
Tc3                      abcd                     abcd        4

*** Keywords ***
Test Color Excel
    [Arguments]       ${after}    ${real}    ${round}
    ${excel_list}=    Create New Excel List in Excel    ColorList    use_pattern=${False}
    Log    ${excel_list}
    ${a}   ${b}   Add String To Excel  ${excel_list}  ColorNone     ColorYes${round}    ${round}
    Log    ${a} | ${b}
    Put Note To Excel    cnt_ok=1    cnt_total=1    ws_name=${excel_list}
    Save Test Case Excel

