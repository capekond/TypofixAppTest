*** Settings ***
Resource   ../resources/keywords/api.robot
Resource   ../resources/keywords/web.robot
Library    SeleniumLibrary
Suite Setup  Setup Web Session
Suite Teardown      Close All Browsers

*** Test Cases ***

Simple compare fixed entry with expected result backup
    [Documentation]    Basic test
    Select Language    Czech (academic rules)
    Select Reference Set    TEST_AUT_ReferenceSet_cz_ak
    Input Text for Corretion    input=Ahoj,Babi
    Correct Text For Correction By Click On Buttons
    Click Element    ${TYPOFIX}
    Element Text Should Be    locator=${INPUT_INNER}    expected=Ahoj, Babi
