*** Settings ***
Library    SeleniumLibrary

*** Variables ***
${BASE_URL}    https://www.typofix.org/

#*** Test Suites ***
#Homepage Tests

*** Test Cases ***
Load Homepage
    [Documentation]    Verify that the homepage loads correctly
    Open Browser    ${BASE_URL}    chrome
    Title Should Be    Typofix.org
    Close Browser

#Verify Content
#    [Documentation]    Verify the content on the homepage
#    Open Browser    ${BASE_URL}    chrome
#    Page Should Contain    Welcome to Typofix!
#    Close Browser
#
#Navigation Links
#    [Documentation]    Verify that navigation links work
#    Open Browser    ${BASE_URL}    chrome
#    Click Link    About
#    Title Should Be    About Us - Typofix
#    Go Back
#    Click Link    Contact
#    Title Should Be    Contact Us - Typofix
#    Close Browser