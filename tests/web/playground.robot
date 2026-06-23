*** Settings ***
Library    String
Library    Collections
Resource   ../resources/keywords/web_admin_keywords.robot
Resource   ../resources/keywords/keywords.robot
Library    ../resources/keywords/KeywordsTypofix.py
#Suite Setup  Admin Let Open Browser
#Test Teardown    Save Test Case Excel
#Suite Teardown      Close All Browsers

*** Test Cases ***

Color Cell Excel
    [Documentation]
    ${excel_list}=    Create New Excel List in Excel    ColorList    use_pattern=${False}
    Log    ${excel_list}
    ${a}   ${b}   Add String To Excel  ${excel_list}  ColorNone     ColorYes
    Log    ${a} | ${b}
    Put Note To Excel    cnt_ok=1    cnt_total=1    ws_name=${excel_list}
    Save Test Case Excel


Load particular example To Excel
    #todo check
    Admin Login If Necessary
    ${True}    ${final_langs}    ${before_ex}    ${after_ex}  Get Link Detail    197    Czech (academic rules), Danish, German (Germany)
    Log    ${after_ex}
    ${after_ex_nbspace}=    Format nbspace Character    ${after_ex}
    Log    ${after_ex_nbspace}
    Create New Excel List In Excel    TestSample    ${False}
    ${cnt}=  Get length   ${final_langs}
    FOR    ${i}    IN RANGE   ${cnt}
        Log    ${final_langs}[${i}] | ${before_ex}[${i}] | ${after_ex_nbspace}[${i}]
    END
    Add Table To Excel    ${final_langs}    ${before_ex}    ${after_ex_nbspace}
    Save Test Case Excel

