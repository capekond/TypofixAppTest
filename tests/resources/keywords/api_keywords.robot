*** Settings ***
Library    RequestsLibrary
Library    OperatingSystem
Resource   ../variables/secret.robot
Resource   ../variables/api_variables.robot

*** Test Cases ***

Create Reference Set
    Create Static Predefind Preference Set    ${EXECDIR}/tests/resources/test_data/ReferenceSetAdd.json

#Delete Reference Set
#    Create Static Predefind Preference Set    ${EXECDIR}/tests/resources/test_data/ReferenceSetDelete.json

*** Keywords ***

Create Static Predefind Preference Set
    [Documentation]   Manage Stetic Predefind Preference Set defind at file in parameter
    [Arguments]    ${file_path}
    ${headers}=    Create Dictionary    Authorization=${BEARER_TOKEN}
    ${payload}=    Get File     ${file_path}
#    ${payload}=    Create Dictionary
#    ...    id=123
#    ...    status=updated
#    ...    message=Hello from Robot Framework
#    ${payload}=    Create Dictionary    ${json_body}

    Create Session    typofix_api    ${API_BASE_URL}    verify=True    debug=1
    ${response}=    PUT On Session
    ...    alias=typofix_api
    ...    url=${API_PATH}
    ...    json=${payload}
    ...    headers=${headers}
    Status Should Be    200    ${response}
    Should Be Equal     ${response.content}    {"status":"ok"}




#Delete Static Predefind Preference Set
#    [Documentation]   Create Stetic Predefind Preference Set defind at test_data/ReferenceSetDelete.json
#    ${response}=    PUT    ${URL}