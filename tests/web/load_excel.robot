*** Settings ***
Library    String
Library    Collections
Resource   ../resources/keywords/web_admin_keywords.robot
Resource   ../resources/keywords/keywords.robot
Library    ../resources/keywords/KeywordsTypofix.py
Suite Setup  Admin Let Open Browser
Test Teardown    Save Test Case Excel
Suite Teardown      Close All Browsers

*** Test Cases ***

Load defined examples to test cases
    [Documentation]   Build excel test cases
    ${excel_list}=    Create New Excel List in Excel
    ${ids}    ${names}    ${descriptions}    ${tags}    ${expecteds_languages}    Get Main Data
    ${cnt}=  Get length   ${ids}
    VAR    ${ok}        0
    VAR    ${nok}       0
    FOR    ${i}    IN RANGE   ${cnt}
       Typofix File Log     ${ids}[${i}]
       ${has_examples}    ${final_languages}   ${befores}    ${afters}    Get Link Detail      ${ids}[${i}]    ${expecteds_languages}[${i}]
       IF    ${has_examples}
          Add New Test Cases To Excel
                ...     excel_list=${excel_list}
                ...     id=${ids}[${i}]
                ...     name=${names}[${i}]
                ...     description=${descriptions}[${i}]
                ...     tag=${tags}[${i}]
                ...     languages=${final_languages}
                ...     befores=${befores}
                ...     afters=${afters}
          ${ok}=    Evaluate    ${ok} + 1
       ELSE
          Log    ${ids}[${i}] ${names}[${i}] has no examples
          ${nok}=    Evaluate    ${nok} + 1
       END
    END
    Put Note To Excel    cnt_ok=${ok}    cnt_nok=${nok}    ws_name=${excel_list}
    Save Test Case Excel

Report rules with missing examples
    [Documentation]   Only report rules with missing examples no test examples created
    Clean Missing Excel List
    ${ids}    ${names}    ${descriptions}    ${tags}    ${expecteds_languages}    Get Main Data
    ${cnt}=  Get length   ${ids}
    VAR    ${ok}        0
    VAR    ${nok}       0
    FOR    ${i}    IN RANGE   ${cnt}
       Typofix File Log    ${ids}[${i}]
       ${has_examples}=     Check if Link Detail has examples    ${ids}[${i}]
       IF    ${has_examples}
          ${nok}=    Evaluate    ${nok} + 1
          Log    ${ids}[${i}] ${names}[${i}] has examples
       ELSE
           ${ok}=    Evaluate    ${ok} + 1
           Add Missing Examples To Excel
                ...     id=${ids}[${i}]
                ...     name=${names}[${i}]
                ...     description=${descriptions}[${i}]
                ...     tag=${tags}[${i}]
                ...     expected_languages=${expecteds_languages}[${i}]
       END
    END
    Put Note To Excel    cnt_ok=${ok}    cnt_nok=${nok}
    Save Test Case Excel

Load particular example To Excel
    Admin Login If Necessary
    ${True}    ${final_langs}    ${before_ex}    ${after_ex}  Get Link Detail    197    Czech (academic rules), Danish, German (Germany)
    Log    ${after_ex}
    ${after_ex}    Format nbspace Character    ${after_ex}
#    Create New Excel List In Excel    TestSample    ${False}
#    ${cnt}=  Get length   ${final_langs}
#    FOR    ${i}    IN RANGE   ${cnt}
#        Log    ${final_langs}[${i}] | ${before_ex}[${i}] | ${after_ex}[${i}]
#    END
#    Add Table To Excel    ${final_langs}    ${before_ex}    ${after_ex}
#    Save Test Case Excel

