*** Settings ***
Documentation     Search functionality test suite for Typofix application
Resource          ../resources/keywords/web_keywords.robot
Resource          ../resources/variables/web_variables.robot
Resource          ../resources/variables/environment.robot
Resource          ../resources/test_data/search_data.robot
Suite Setup       Open Browser To Typofix
Suite Teardown    Close Browser

*** Test Cases ***
User Can Perform Basic Search
    [Documentation]    Test basic search functionality
    [Tags]    smoke    search    positive
    Perform Search    ${SEARCH_TERM_BASIC}
    Verify Search Results Are Displayed
    Verify Results Contain Search Term    ${SEARCH_TERM_BASIC}

Search Returns No Results For Non-Existent Term
    [Documentation]    Test search with term that returns no results
    [Tags]    search    negative
    Perform Search    ${SEARCH_TERM_NONEXISTENT}
    Verify No Search Results Message Is Displayed

User Can Apply Search Filters
    [Documentation]    Test search with filters
    [Tags]    smoke    search    filters
    Perform Search    ${SEARCH_TERM_BASIC}
    Apply Filter    ${FILTER_CATEGORY}    ${FILTER_VALUE}
    Verify Filtered Results Are Displayed
    Verify Results Match Filter    ${FILTER_VALUE}

User Can Sort Search Results
    [Documentation]    Test sorting search results
    [Tags]    search    sorting
    Perform Search    ${SEARCH_TERM_BASIC}
    Sort Results By    ${SORT_BY_RELEVANCE}
    Verify Results Are Sorted Correctly

User Can Paginate Search Results
    [Documentation]    Test pagination in search results
    [Tags]    search    pagination
    Perform Search    ${SEARCH_TERM_BASIC}
    Verify Pagination Controls Are Visible
    Go To Next Page
    Verify Page Has Changed

User Can Search From Homepage
    [Documentation]    Test search from homepage search widget
    [Tags]    smoke    search    homepage
    Perform Search From Homepage Widget    ${SEARCH_TERM_BASIC}
    Verify Search Results Page Is Loaded
    Verify Results Contain Search Term    ${SEARCH_TERM_BASIC}