*** Settings ***
Resource    ../resources/keywords/api_tested_keywords.robot
Resource    ../resources/keywords/web_tested_keywords.robot
Library    SeleniumLibrary
Library    ../keywords/KeywordsTypofix.py

Suite Setup  Let Open Browser and Set All Preferences
Suite Teardown      Close All Browsers


*** Test Cases ***
Check correction data
    Login If Necessary
    Select Language    Czech (academic rules)
    Select Reference Set    test-czech-academic-rules
    Input Text for Corretion    input=Guns’N’Roses\nGuns n'Roses\nGuns ‘N’ Roses
    Correct Text For Correction By Click On Buttons    1
    ${s}=    Get Text    ${OUTPUT_INNER}
    Log To Console    ${s}
    Log To Console    ${s}
