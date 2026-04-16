*** Settings ***
Documentation     Search API endpoint test suite for Typofix application
Library           Collections
Library           RequestsLibrary
Resource          ../resources/keywords/api_keywords.robot
Resource          ../resources/variables/api_variables.robot
Resource          ../resources/variables/environment.robot
Resource          ../resources/test_data/search_data.robot
Suite Setup       Initialize API Session
Suite Teardown    Close All Connections

*** Test Cases ***
Search API Returns Results
    [Documentation]    Test basic search API functionality
    [Tags]    smoke    api    search    positive
    ${response}=    GET    ${API_BASE_URL}${SEARCH_ENDPOINT}?q=${SEARCH_TERM_BASIC}
    Verify Response Status    ${response}    200
    Verify Search Results Exist    ${response}

Search API With Multiple Filters
    [Documentation]    Test search API with filter parameters
    [Tags]    api    search    filters
    ${params}=    Create Dictionary    q=${SEARCH_TERM_BASIC}    category=${FILTER_CATEGORY}    limit=10
    ${response}=    GET    ${API_BASE_URL}${SEARCH_ENDPOINT}    params=${params}
    Verify Response Status    ${response}    200
    Verify Filtered Results    ${response}    ${FILTER_CATEGORY}

Search API With Pagination
    [Documentation]    Test search API pagination
    [Tags]    api    search    pagination
    ${params}=    Create Dictionary    q=${SEARCH_TERM_BASIC}    offset=0    limit=10
    ${response}=    GET    ${API_BASE_URL}${SEARCH_ENDPOINT}    params=${params}
    Verify Response Status    ${response}    200
    Verify Pagination In Response    ${response}

Search API With Invalid Query
    [Documentation]    Test search API with empty query
    [Tags]    api    search    negative
    ${response}=    GET    ${API_BASE_URL}${SEARCH_ENDPOINT}?q=
    Verify Response Status    ${response}    400

Search API Response Format
    [Documentation]    Test search API response structure
    [Tags]    api    search    positive
    ${response}=    GET    ${API_BASE_URL}${SEARCH_ENDPOINT}?q=${SEARCH_TERM_BASIC}
    Verify Response Status    ${response}    200
    Verify Response Has Required Fields    ${response}    results    total_count    query

Advanced Search With Sort
    [Documentation]    Test advanced search with sorting
    [Tags]    api    search    advanced
    ${params}=    Create Dictionary    q=${SEARCH_TERM_BASIC}    sort=relevance    order=desc
    ${response}=    GET    ${API_BASE_URL}${SEARCH_ENDPOINT}    params=${params}
    Verify Response Status    ${response}    200
    Verify Results Are Sorted    ${response}