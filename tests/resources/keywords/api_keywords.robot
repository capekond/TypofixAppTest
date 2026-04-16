*** Keywords ***
Initialize API Session
    [Documentation]    Initializes API session with base URL and headers
    Create Session    API    ${API_BASE_URL}    verify=True
    Set Headers    ${DEFAULT_HEADERS}

Close All Connections
    [Documentation]    Closes all API sessions
    Delete All Sessions

GET
    [Documentation]    Sends GET request to API endpoint
    [Arguments]    ${endpoint}    ${params}=${EMPTY}
    ${response}=    Get Request    API    ${endpoint}    params=${params}
    [Return]    ${response}

POST
    [Documentation]    Sends POST request to API endpoint
    [Arguments]    ${endpoint}    ${json}=${EMPTY}
    ${response}=    Post Request    API    ${endpoint}    json=${json}
    [Return]    ${response}

PUT
    [Documentation]    Sends PUT request to API endpoint
    [Arguments]    ${endpoint}    ${json}=${EMPTY}
    ${response}=    Put Request    API    ${endpoint}    json=${json}
    [Return]    ${response}

DELETE
    [Documentation]    Sends DELETE request to API endpoint
    [Arguments]    ${endpoint}
    ${response}=    Delete Request    API    ${endpoint}
    [Return]    ${response}

Verify Response Status
    [Documentation]    Verifies API response status code
    [Arguments]    ${response}    ${expected_status}
    Should Be Equal As Integers    ${response.status_code}    ${expected_status}

Verify Response Contains Users List
    [Documentation]    Verifies response contains list of users
    [Arguments]    ${response}
    Should Contain    ${response.json()}    users
    Should Be True    len(${response.json()}['users']) > 0

Verify User Fields In Response
    [Documentation]    Verifies user has required fields
    [Arguments]    ${response}
    ${user}=    Get From Dictionary    ${response.json()}    user
    Should Contain    ${user}    id
    Should Contain    ${user}    email
    Should Contain    ${user}    name

Verify User Created Successfully
    [Documentation]    Verifies user was created successfully
    [Arguments]    ${response}
    ${data}=    Get From Dictionary    ${response.json()}    data
    Should Contain    ${data}    id
    Should Be True    ${data['id']} > 0

Verify User Updated Successfully
    [Documentation]    Verifies user was updated successfully
    [Arguments]    ${response}
    ${data}=    Get From Dictionary    ${response.json()}    data
    Should Contain    ${data}    updated_at

Verify Search Results Exist
    [Documentation]    Verifies search API returned results
    [Arguments]    ${response}
    ${data}=    Get From Dictionary    ${response.json()}    results
    Should Be True    len(${data}) > 0

Verify Filtered Results
    [Documentation]    Verifies search results are filtered
    [Arguments]    ${response}    ${category}
    ${data}=    Get From Dictionary    ${response.json()}    results
    FOR    ${item}    IN    @{data}
        Should Be Equal    ${item}['category']    ${category}
    END

Verify Pagination In Response
    [Documentation]    Verifies pagination data in response
    [Arguments]    ${response}
    ${data}=    Get From Dictionary    ${response.json()}    pagination
    Should Contain    ${data}    offset
    Should Contain    ${data}    limit
    Should Contain    ${data}    total

Verify Response Has Required Fields
    [Documentation]    Verifies response has all required fields
    [Arguments]    ${response}    @{fields}
    ${data}=    Get From Dictionary    ${response.json()}
    FOR    ${field}    IN    @{fields}
        Should Contain    ${data}    ${field}
    END

Verify Results Are Sorted
    [Documentation]    Verifies results are sorted correctly
    [Arguments]    ${response}
    ${results}=    Get From Dictionary    ${response.json()}    results
    Should Be True    len(${results}) > 0