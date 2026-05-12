*** Settings ***
Resource   ../resources/keywords/web_admin_keywords.robot
Suite Setup  Admin Let Open Browser
#Suite Teardown      Close All Browsers

*** Test Cases ***
Add defined examples to data store
    [Documentation]   Build data store
    Admin Login If Necessary
    Admin Get All Text Replaces


Nested container
    ${nested} =    Evaluate    [['a', 'b', 'c'], {'key': ['x', 'y']}]
    Log Many    @{nested}[0]         # Logs 'a', 'b' and 'c'.
    Log Many    @{nested}[1][key]    # Logs 'x' and 'y'.




