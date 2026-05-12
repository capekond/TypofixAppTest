*** Variables ***


*** Settings ***
Resource   ../resources/keywords/api_tested_keywords.robot
Resource   ../resources/keywords/web_tested_keywords.robot
Library    SeleniumLibrary
Suite Setup  Let Open Browser    ${ADMIN_BASE_URL}
#Suite Teardown      Close All Browsers


*** Test Cases ***
Add defined examples to data store
    [Documentation]   Build data store


*** Keywords ***


