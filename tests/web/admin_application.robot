*** Settings ***
Resource   ../resources/keywords/web_admin_keywords.robot
Suite Setup  Admin Let Open Browser
#Suite Teardown      Close All Browsers

*** Test Cases ***
Add defined examples to data store
    [Documentation]   Build data store
    Admin Login If Necessary
    Admin Get All Text Replaces






