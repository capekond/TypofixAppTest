*** Settings ***
Documentation     Example test cases using the data-driven testing approach.
Test Template     Show

*** Test Cases ***   language                   preference                    given        expected
Space after comma    Czech (academic rules)    TEST_AUT_ReferenceSet_cz_ak    Ahoj,babi   Ahoj babi
Wrong format viz     Czech (academic rules)    TEST_AUT_ReferenceSet_cz_ak    viz.        viz


*** Keywords ***
Show
    [Arguments]       ${language}    ${preference}    ${given}    ${expected}
    Log To Console    ${language}
    Log To Console    ${preference}
    Log To Console    ${given}
    Log To Console    ${expected}