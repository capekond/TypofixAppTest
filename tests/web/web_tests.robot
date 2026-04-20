*** Settings ***
Resource   ../resources/keywords/api.robot
Resource   ../resources/keywords/web.robot
Library    SeleniumLibrary

*** Test Cases ***

Simple compare fixed entry with expected result
    [Documentation]    Basic test
    Set Predefined Preference    ${EXECDIR}/tests/resources/test_data/ReferenceSetAdd.json
    Open Browser And Login If Necessary
    Select Language    Czech (academic rules)
    Select Reference Set    TEST_AUT_ReferenceSet_cz_ak
    Input Text for Corretion    input=Ahoj,Babi
    Click Element    ${TYPOFIX}
    Element Text Should Be    locator=${INPUT_INNER}    expected=Ahoj, Babi