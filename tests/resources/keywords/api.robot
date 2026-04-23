*** Settings ***
Library    RequestsLibrary
Library    OperatingSystem
Library    ../keywords/KeywordsTypofix.py
Resource   ../variables/secret.robot
Resource   ../variables/api.robot

*** Keywords ***

Set Predefined Preference
    [Documentation]   Manage Stetic Predefind Preference Set defind at file in parameter
    [Arguments]    ${file_part_name}
    ${headers}=    Create Dictionary    Authorization=${BEARER_TOKEN}
    ${payload}=    Get Json Reference File    ${file_part_name}
    Create Session    typofix_api    ${API_BASE_URL}    verify=True    debug=1
    ${response}=    PUT On Session
    ...    alias=typofix_api
    ...    url=${API_REFERENCE_SETS}
    ...    json=${payload}
    ...    headers=${headers}
    Status Should Be    200    ${response}
    Should Be Equal     ${response.content}    {"status":"ok"}