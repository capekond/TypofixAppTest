*** Settings ***
Resource   ../resources/keywords/api.robot
Resource   ../resources/keywords/web.robot
Library    SeleniumLibrary
*** Variables ***
${BASE_URL}   https://www.typofix.org/application

*** Test Cases ***

Simple compare fixed entry with expected result
    [Documentation]    Basic test
    Set Predefined Preference    ${EXECDIR}/tests/resources/test_data/ReferenceSetAdd.json
    Open Browser And Login If Necessary
#    Select Language
#    Select Reference Set
#    Wait Until Element Is Enabled
    Close Browser