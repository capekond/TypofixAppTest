*** Settings ***
Library    SeleniumLibrary
Resource   ../variables/web_variables.robot
Resource   ../variables/environment.robot

*** Keywords ***
Open Browser To Typofix
    [Documentation]    Opens a browser and navigates to the Typofix homepage
    Open Browser    ${BASE_URL}    ${BROWSER}
    Maximize Browser Window

Close Browser
    [Documentation]    Closes the current browser session
    Close All Browsers

Input Username
    [Documentation]    Enters username into login form
    [Arguments]    ${username}
    Input Text    id:username    ${username}

Input Password
    [Documentation]    Enters password into login form
    [Arguments]    ${password}
    Input Text    id:password    ${password}

Click Login Button
    [Documentation]    Clicks the login button
    Click Element   xpath://button[@type='submit']

Verify Login Success
    [Documentation]    Verifies successful login by checking for dashboard
    Wait Until Element Is Visible   xpath://div[@class='dashboard']     timeout=10s

Verify Login Error Message
    [Documentation]    Verifies login error message is displayed
    Wait Until Element Is Visible   xpath://div[@class='error-message']       timeout=5s

Verify User Is Still Logged In
    [Documentation]    Verifies user remains logged in after page refresh
    Wait Until Element Is Visible    xpath://div[@class='user-menu']        timeout=5s

Verify Username Field Is Visible
    [Documentation]    Checks if username input field is visible
    Wait Until Element Is Visible   id:username

Verify Password Field Is Visible
    [Documentation]    Checks if password input field is visible
    Wait Until Element Is Visible  id:password

Verify Login Button Is Visible
    [Documentation]    Checks if login button is visible
    Wait Until Element Is Visible    xpath://button[@type='submit']

Verify Forgot Password Link Is Visible
    [Documentation]    Checks if forgot password link is visible
    Wait Until Element Is Visible    xpath://a[contains(text(), 'Forgot')]

Refresh Page
    [Documentation]    Refreshes the current page
    Reload Page

Verify Homepage Title
    [Documentation]    Verifies the homepage title is correct
    Get Title     Typofix - Correct Your Typos

Verify Homepage Header Is Visible
    [Documentation]    Verifies homepage header is visible
    Wait Until Element Is Visible    xpath://header[@class='main-header']   timeout=5s

Verify Navigation Menu Is Visible
    [Documentation]    Verifies navigation menu is visible
    Wait Until Element Is Visible    xpath://nav[@class='navbar']

Verify Home Link In Menu
    [Documentation]    Verifies home link in navigation menu
    Wait Until Element Is Visible    xpath://a[contains(text(), 'Home')]

Verify Search Link In Menu
    [Documentation]    Verifies search link in navigation menu
    Wait Until Element Is Visible   xpath://a[contains(text(), 'Search')]

Verify About Link In Menu
    [Documentation]    Verifies about link in navigation menu
    Wait Until Element Is Visible    xpath://a[contains(text(), 'About')]

Verify Contact Link In Menu
    [Documentation]    Verifies contact link in navigation menu
    Wait Until Element Is Visible    xpath://a[contains(text(), 'Contact')]

Verify Featured Section Is Visible
    [Documentation]    Verifies featured content section is visible
    Wait Until Element Is Visible    xpath://section[@class='featured']

Verify Featured Items Count Is At Least
    [Documentation]    Verifies minimum number of featured items
    [Arguments]    ${count}
    Wait Until Element Is Visible     xpath://section[@class='featured']//article    >=    ${count}

Verify Search Widget Is Visible
    [Documentation]    Verifies search widget on homepage is visible
    Wait Until Element Is Visible     xpath://div[@class='search-widget']    *=visible

Verify Search Input Field Is Active
    [Documentation]    Verifies search input field is active
    Wait Until Element Is Visible     id:search-input    *=enabled

Verify Search Button Is Visible
    [Documentation]    Verifies search button is visible
    Wait Until Element Is Visible     xpath://button[contains(@class, 'search-button')]

Verify Facebook Link Is Present
    [Documentation]    Verifies Facebook social media link
    Wait Until Element Is Visible     xpath://a[@data-social='facebook']

Verify Twitter Link Is Present
    [Documentation]    Verifies Twitter social media link
    Wait Until Element Is Visible     xpath://a[@data-social='twitter']

Verify LinkedIn Link Is Present
    [Documentation]    Verifies LinkedIn social media link
    Wait Until Element Is Visible     xpath://a[@data-social='linkedin']

Perform Search
    [Documentation]    Performs a search with given term
    [Arguments]    ${search_term}
    Input Text    id:search-input    ${search_term}
    Click Element   xpath://button[contains(@class, 'search-button')]
    Wait For Navigation

Perform Search From Homepage Widget
    [Documentation]    Performs search using homepage widget
    [Arguments]    ${search_term}
    Input Text    xpath://div[@class='search-widget']//input    ${search_term}
    Click Element   xpath://div[@class='search-widget']//button
    Wait For Navigation

Verify Search Results Are Displayed
    [Documentation]    Verifies search results page is displayed
    Wait Until Element Is Visible    xpath://div[@class='search-results']    timeout=10s

Verify Results Contain Search Term
    [Documentation]    Verifies search results contain the search term
    [Arguments]    ${term}
    Wait Until Element Is Visible    xpath://div[@class='search-results' and contains(., '${term}')]

Verify No Search Results Message Is Displayed
    [Documentation]    Verifies no results message is shown
    Wait Until Element Is Visible    xpath://div[@class='no-results']    timeout=5s

Apply Filter
    [Documentation]    Applies a filter to search results
    [Arguments]    ${category}    ${value}
    Click Element   xpath://input[@value='${category}']
    Wait Until Element Is Visible  xpath://label[contains(., '${value}')]    timeout=5s
    Click Element   xpath://label[contains(., '${value}')]

Verify Filtered Results Are Displayed
    [Documentation]    Verifies filtered results are displayed
    Wait Until Element Is Visible    xpath://div[@class='filtered-results']  timeout=5s

Verify Results Match Filter
    [Documentation]    Verifies results match applied filter
    [Arguments]    ${filter_value}
    Get Element    xpath://div[@class='search-results' and contains(., '${filter_value}')]

Sort Results By
    [Documentation]    Sorts results by specified criteria
    [Arguments]    ${sort_option}
    Click Element  xpath://select[@id='sort-by']
    Click Element  xpath://option[contains(text(), '${sort_option}')]

Verify Results Are Sorted Correctly
    [Documentation]    Verifies results are sorted correctly
    Wait Until Element Is Visible    xpath://div[@class='sorted-results']   timeout=5s

Go To Next Page
    [Documentation]    Navigates to next page of results
    Click Element    xpath://a[@rel='next']
    Wait For Navigation

Verify Page Has Changed
    [Documentation]    Verifies page content has changed after navigation
    Wait Until Element Is Visible    xpath://div[@class='pagination-info']  timeout=5s

Verify Search Results Page Is Loaded
    [Documentation]    Verifies search results page is fully loaded
    Wait Until Element Is Visible    xpath://div[@class='search-results']     timeout=10s

Wait For Navigation
    [Documentation]    Waits for page navigation to complete
    Wait For Load State    networkidle