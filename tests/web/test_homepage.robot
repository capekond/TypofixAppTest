*** Settings ***
Documentation     Homepage functionality test suite for Typofix application
Resource          ../resources/keywords/web_keywords.robot
Resource          ../resources/variables/web_variables.robot
Resource          ../resources/variables/environment.robot
Suite Setup       Open Browser To Typofix
Suite Teardown    Close Browser

*** Test Cases ***
Homepage Loads Successfully
    [Documentation]    Test that homepage loads without errors
    [Tags]    smoke    homepage    positive
    Verify Homepage Title
    Verify Homepage Header Is Visible

Navigation Menu Is Accessible
    [Documentation]    Verify all navigation menu items are visible
    [Tags]    smoke    homepage    ui
    Verify Navigation Menu Is Visible
    Verify Home Link In Menu
    Verify Search Link In Menu
    Verify About Link In Menu
    Verify Contact Link In Menu

Featured Content Is Displayed
    [Documentation]    Verify featured content is displayed on homepage
    [Tags]    homepage    content
    Verify Featured Section Is Visible
    Verify Featured Items Count Is At Least    3

Search Widget Is Available
    [Documentation]    Verify search widget is available on homepage
    [Tags]    smoke    homepage    search
    Verify Search Widget Is Visible
    Verify Search Input Field Is Active
    Verify Search Button Is Visible

Social Media Links Are Present
    [Documentation]    Verify social media links are present
    [Tags]    homepage    links
    Verify Facebook Link Is Present
    Verify Twitter Link Is Present
    Verify LinkedIn Link Is Present