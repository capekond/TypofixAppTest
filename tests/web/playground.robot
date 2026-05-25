*** Settings ***
Library    String
Library    Collections

*** Test Cases ***
Check Exemple
    ${a}=    For Looop
    Log    Prvni ${a}[0]
    Log    Druhy ${a}[1]
    Log    Treti ${a}[2]


*** Keywords ***
For Looop
    VAR    ${list}=    a,b,c
    @{COLUMNS}=    Split String    ${list}    separator=,
    @{FIRST}=    Create List    AA    BB    CC
    @{SECOND}=   Create List    AAA    BBB    CCC
    FOR    ${a}    IN    @{COLUMNS}
        Log To Console    ${a}
    END
    RETURN    ${list}    ${FIRST}    ${SECOND}
