*** Settings ***
Library  RequestsLibrary

*** Variables ***
${BASE_URL}    https://www.typofix.org/

*** Test Cases ***
GET Request Test
    [Documentation]    Test GET request for base URL
    ${response}=    Get Request    ${BASE_URL}
    Should Be Equal As Strings    ${response.status_code}    200
    Log    Response: ${response.text}

POST Request Test
    [Documentation]    Test POST request for base URL
    ${data}=    Create Dictionary    key1=value1    key2=value2
    ${response}=    Post Request    ${BASE_URL}    json=${data}
    Should Be Equal As Strings    ${response.status_code}    201
    Log    Response: ${response.json()}

*** Keywords ***
Get Request
    [Arguments]    ${url}
    ${response}=    GET    ${url}
    RETURN    ${response}

Post Request
    [Arguments]    ${url}    ${data}
    ${response}=    POST    ${url}    json=${data}
    RETURN    ${response}