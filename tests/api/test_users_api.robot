*** Settings ***
Documentation     User API endpoint test suite for Typofix application
Library           Collections
Library           RequestsLibrary
Resource          ../resources/keywords/api_keywords.robot
Resource          ../resources/variables/api_variables.robot
Resource          ../resources/variables/environment.robot
Resource          ../resources/test_data/users.robot
Suite Setup       Initialize API Session
Suite Teardown    Close All Connections

*** Test Cases ***
Get All Users
    [Documentation]    Test GET request to retrieve all users
    [Tags]    smoke    api    users    positive
    ${response}=    GET    ${API_BASE_URL}${USERS_ENDPOINT}
    Verify Response Status    ${response}    200
    Verify Response Contains Users List    ${response}

Get User By ID
    [Documentation]    Test GET request to retrieve specific user
    [Tags]    smoke    api    users    positive
    ${response}=    GET    ${API_BASE_URL}${USERS_ENDPOINT}/${VALID_USER_ID}
    Verify Response Status    ${response}    200
    Verify User Fields In Response    ${response}

Get Non-Existent User Returns 404
    [Documentation]    Test GET request for non-existent user
    [Tags]    api    users    negative
    ${response}=    GET    ${API_BASE_URL}${USERS_ENDPOINT}/99999
    Verify Response Status    ${response}    404

Create New User
    [Documentation]    Test POST request to create new user
    [Tags]    smoke    api    users    positive
    ${response}=    POST    ${API_BASE_URL}${USERS_ENDPOINT}    json=${NEW_USER_DATA}
    Verify Response Status    ${response}    201
    Verify User Created Successfully    ${response}

Create User With Invalid Data
    [Documentation]    Test POST request with invalid user data
    [Tags]    api    users    negative
    ${response}=    POST    ${API_BASE_URL}${USERS_ENDPOINT}    json=${INVALID_USER_DATA}
    Verify Response Status    ${response}    400

Update User
    [Documentation]    Test PUT request to update user
    [Tags]    smoke    api    users    positive
    ${response}=    PUT    ${API_BASE_URL}${USERS_ENDPOINT}/${VALID_USER_ID}    json=${UPDATE_USER_DATA}
    Verify Response Status    ${response}    200
    Verify User Updated Successfully    ${response}

Delete User
    [Documentation]    Test DELETE request to remove user
    [Tags]    api    users    positive
    ${response}=    DELETE    ${API_BASE_URL}${USERS_ENDPOINT}/${VALID_USER_ID}
    Verify Response Status    ${response}    204

Search Users By Email
    [Documentation]    Test searching users by email
    [Tags]    api    users    search
    ${response}=    GET    ${API_BASE_URL}${USERS_ENDPOINT}?email=test@typofix.org
    Verify Response Status    ${response}    200
    Verify Response Contains Users List    ${response}