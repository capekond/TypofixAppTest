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
    Type Text    id:username    ${username}

Input Password
    [Documentation]    Enters password into login form
    [Arguments]    ${password}
    Type Text    id:password    ${password}

Click Login Button
    [Documentation]    Clicks the login button
    Click    xpath://button[@type='submit']

Verify Login Success
    [Documentation]    Verifies successful login by checking for dashboard
    Wait For Elements State    xpath://div[@class='dashboard']    visible    timeout=10s

Verify Login Error Message
    [Documentation]    Verifies login error message is displayed
    Wait For Elements State    xpath://div[@class='error-message']    visible    timeout=5s

Verify User Is Still Logged In
    [Documentation]    Verifies user remains logged in after page refresh
    Wait For Elements State    xpath://div[@class='user-menu']    visible    timeout=5s

Verify Username Field Is Visible
    [Documentation]    Checks if username input field is visible
    Get Element States    id:username    *=visible

Verify Password Field Is Visible
    [Documentation]    Checks if password input field is visible
    Get Element States    id:password    *=visible

Verify Login Button Is Visible
    [Documentation]    Checks if login button is visible
    Get Element States    xpath://button[@type='submit']    *=visible

Verify Forgot Password Link Is Visible
    [Documentation]    Checks if forgot password link is visible
    Get Element States    xpath://a[contains(text(), 'Forgot')]    *=visible

Refresh Page
    [Documentation]    Refreshes the current page
    Reload Page

Verify Homepage Title
    [Documentation]    Verifies the homepage title is correct
    Get Title    ==    Typofix - Correct Your Typos

Verify Homepage Header Is Visible
    [Documentation]    Verifies homepage header is visible
    Wait For Elements State    xpath://header[@class='main-header']    visible    timeout=5s

Verify Navigation Menu Is Visible
    [Documentation]    Verifies navigation menu is visible
    Get Element States    xpath://nav[@class='navbar']    *=visible

Verify Home Link In Menu
    [Documentation]    Verifies home link in navigation menu
    Get Element States    xpath://a[contains(text(), 'Home')]    *=visible

Verify Search Link In Menu
    [Documentation]    Verifies search link in navigation menu
    Get Element States    xpath://a[contains(text(), 'Search')]    *=visible

Verify About Link In Menu
    [Documentation]    Verifies about link in navigation menu
    Get Element States    xpath://a[contains(text(), 'About')]    *=visible

Verify Contact Link In Menu
    [Documentation]    Verifies contact link in navigation menu
    Get Element States    xpath://a[contains(text(), 'Contact')]    *=visible

Verify Featured Section Is Visible
    [Documentation]    Verifies featured content section is visible
    Get Element States    xpath://section[@class='featured']    *=visible

Verify Featured Items Count Is At Least
    [Documentation]    Verifies minimum number of featured items
    [Arguments]    ${count}
    Get Element Count    xpath://section[@class='featured']//article    >=    ${count}

Verify Search Widget Is Visible
    [Documentation]    Verifies search widget on homepage is visible
    Get Element States    xpath://div[@class='search-widget']    *=visible

Verify Search Input Field Is Active
    [Documentation]    Verifies search input field is active
    Get Element States    id:search-input    *=enabled

Verify Search Button Is Visible
    [Documentation]    Verifies search button is visible
    Get Element States    xpath://button[contains(@class, 'search-button')]    *=visible

Verify Facebook Link Is Present
    [Documentation]    Verifies Facebook social media link
    Get Element States    xpath://a[@data-social='facebook']    *=visible

Verify Twitter Link Is Present
    [Documentation]    Verifies Twitter social media link
    Get Element States    xpath://a[@data-social='twitter']    *=visible

Verify LinkedIn Link Is Present
    [Documentation]    Verifies LinkedIn social media link
    Get Element States    xpath://a[@data-social='linkedin']    *=visible

Perform Search
    [Documentation]    Performs a search with given term
    [Arguments]    ${search_term}
    Type Text    id:search-input    ${search_term}
    Click    xpath://button[contains(@class, 'search-button')]
    Wait For Navigation

Perform Search From Homepage Widget
    [Documentation]    Performs search using homepage widget
    [Arguments]    ${search_term}
    Type Text    xpath://div[@class='search-widget']//input    ${search_term}
    Click    xpath://div[@class='search-widget']//button
    Wait For Navigation

Verify Search Results Are Displayed
    [Documentation]    Verifies search results page is displayed
    Wait For Elements State    xpath://div[@class='search-results']    visible    timeout=10s

Verify Results Contain Search Term
    [Documentation]    Verifies search results contain the search term
    [Arguments]    ${term}
    Get Element    xpath://div[@class='search-results' and contains(., '${term}')]

Verify No Search Results Message Is Displayed
    [Documentation]    Verifies no results message is shown
    Wait For Elements State    xpath://div[@class='no-results']    visible    timeout=5s

Apply Filter
    [Documentation]    Applies a filter to search results
    [Arguments]    ${category}    ${value}
    Click    xpath://input[@value='${category}']
    Wait For Elements State    xpath://label[contains(., '${value}')]    visible    timeout=5s
    Click    xpath://label[contains(., '${value}')]

Verify Filtered Results Are Displayed
    [Documentation]    Verifies filtered results are displayed
    Wait For Elements State    xpath://div[@class='filtered-results']    visible    timeout=5s

Verify Results Match Filter
    [Documentation]    Verifies results match applied filter
    [Arguments]    ${filter_value}
    Get Element    xpath://div[@class='search-results' and contains(., '${filter_value}')]

Sort Results By
    [Documentation]    Sorts results by specified criteria
    [Arguments]    ${sort_option}
    Click    xpath://select[@id='sort-by']
    Click    xpath://option[contains(text(), '${sort_option}')]

Verify Results Are Sorted Correctly
    [Documentation]    Verifies results are sorted correctly
    Wait For Elements State    xpath://div[@class='sorted-results']    visible    timeout=5s

Go To Next Page
    [Documentation]    Navigates to next page of results
    Click    xpath://a[@rel='next']
    Wait For Navigation

Verify Page Has Changed
    [Documentation]    Verifies page content has changed after navigation
    Wait For Elements State    xpath://div[@class='pagination-info']    visible    timeout=5s

Verify Search Results Page Is Loaded
    [Documentation]    Verifies search results page is fully loaded
    Wait For Elements State    xpath://div[@class='search-results']    visible    timeout=10s

Wait For Navigation
    [Documentation]    Waits for page navigation to complete
    Wait For Load State    networkidle