*** Settings ***
Resource   ../resources/keywords/api.robot
Resource   ../resources/keywords/web.robot
Library    SeleniumLibrary
Suite Setup  Set Predefined Preference  ${EXECDIR}/tests/resources/test_data/ReferenceSetAdd.json  Open Browser And Login If Necessary

Suite Teardown      Close All Browsers

*** Test Cases ***

Simple compare fixed entry with expected result
    [Documentation]    Basic test
    Select Language    Czech (academic rules)
    Select Reference Set    TEST_AUT_ReferenceSet_cz_ak
    Input Text for Corretion    input=Ahoj,Babi
    Correct Text For Correction By Click On Buttons
    Click Element    ${TYPOFIX}
    Element Text Should Be    locator=${INPUT_INNER}    expected=Ahoj, Babi
