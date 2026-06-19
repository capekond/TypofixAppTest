*** Settings ***
Documentation     Example test cases using the data-driven testing approach.
Test Template     Test Color Excel

*** Test Cases ***       after                    real
Tc1                      abcd                     abxcd
Tc2                      abcd                     xabxd
Tc3                      abcd                     abcd1
Tc3                      abcd                     abcd

*** Keywords ***
Test Color Excel
    [Arguments]       ${after}    ${before}
    Log To Console    ${after}
    Log To Console    ${before}
