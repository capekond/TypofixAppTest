*** Settings ***
Library    String
Library    Collections

*** Test Cases ***
Check Exemple
    ${a}=    For Looop
    Log    Prvni ${a}[0]
    Log    Druhy ${a}[1]
    Log    Treti ${a}[2]
    Log    Linked ${a}[0][0] : ${a}[0][1]


*** Keywords ***
For Looop

    @{link}=     Create List      link    http link
    @{FIRST}=    Create List
    @{SECOND}=   Create List    AAA    BBB    CCC

    VAR    ${list}=    a,b,c
    @{COLUMNS}=    Split String    ${list}    separator=,
    FOR    ${a}    IN    @{COLUMNS}
        Append To List    ${FIRST}    Line ${a}
        Log To Console    ${a}
    END

    RETURN    ${link}    ${FIRST}    ${SECOND}
