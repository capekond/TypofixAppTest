*** Settings ***
Library    RequestsLibrary
Library    OperatingSystem
Library    ../keywords/KeywordsTypofix.py
Resource   ../variables/secret.robot
Resource   ../variables/api.robot

*** Keywords ***

Set Predefined Preference
    [Documentation]   Manage Stetic Predefind Preference Set defind at file in parameter
    [Arguments]    ${file_path}
    ${headers}=    Create Dictionary    Authorization=${BEARER_TOKEN}
    ${payload}=    Get Json File    ${file_path}
    Create Session    typofix_api    ${API_BASE_URL}    verify=True    debug=1
    ${response}=    PUT On Session
    ...    alias=typofix_api
    ...    url=${API_PATH}
    ...    json=${payload}
    ...    headers=${headers}
    Status Should Be    200    ${response}
    Should Be Equal     ${response.content}    {"status":"ok"}