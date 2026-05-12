*** Variables ***


*** Settings ***
Resource   ../resources/keywords/web_admin_keywords.robot
Library    SeleniumLibrary
Suite Setup  Admin Let Open Browser
#Suite Teardown      Close All Browsers


*** Test Cases ***
Add defined examples to data store
    [Documentation]   Build data store


*** Keywords ***


