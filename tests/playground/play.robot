*** Settings ***
Library           RequestsLibrary
Library           Collections

*** Variables ***
${BASE_URL}       https://typofix.slonline.sk
${API_PATH}       /api
${BEARER_TOKEN}   4a0xxxx

*** Test Cases ***
Update Data Via Put Request
    [Documentation]    Sends a PUT request to the Typofix API with Bearer Authorization.

    # 1. Prepare Headers
    ${headers}=    Create Dictionary
    ...    Authorization=Bearer ${BEARER_TOKEN}
    ...    Content-Type=application/json

    # 2. Prepare Data (Body of the PUT request)
    ${body}=       Create Dictionary    key=value    example_field=updated_data

    # 3. Create Session
    Create Session    typofix_api    ${BASE_URL}    verify=True

    # 4. Execute PUT Request
    ${response}=    PUT On Session
    ...    typofix_api
    ...    ${API_PATH}
    ...    json=${body}
    ...    headers=${headers}

    # 5. Assertions
    Status Should Be    200    ${response}
    Log To Console      \nResponse Body: ${response.content}