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

Load defined examples to test cases and report rules with missing examples
    [Documentation]   Build excel test cases report rules with missing examples
    ${excel_list}=    Create New Excel List in Excel
    ${ids}    ${names}    ${descriptions}    ${tags}    ${expecteds_languages}    Get Main Data
    ${cnt}=  Get length   ${ids}
    VAR    ${ok_tc}        0
    VAR    ${ok_missing}        0
    FOR    ${i}    IN RANGE   ${cnt}
       Typofix File Log     ${ids}[${i}]
       ${has_examples}    ${final_languages}   ${befores}    ${afters}    Get Link Detail      ${ids}[${i}]    ${expecteds_languages}[${i}]
       Log    ${i}/${cnt} "test info: ${names}[${i}] Has examples: ${has_examples} Languages: ${final_languages} Before: ${befores} After: ${afters}
       IF    ${has_examples}
          ${ok_tc}=    Evaluate    ${ok_tc} + 1
          Add New Test Cases To Excel
                ...     excel_list=${excel_list}
                ...     id=${ids}[${i}]
                ...     name=${names}[${i}]
                ...     description=${descriptions}[${i}]
                ...     tag=${tags}[${i}]
                ...     languages=${final_languages}
                ...     befores=${befores}
                ...     afters=${afters}
       ELSE
           ${ok_missing}=    Evaluate    ${ok_missing} + 1
           Add Missing Examples To Excel
                ...     id=${ids}[${i}]
                ...     name=${names}[${i}]
                ...     description=${descriptions}[${i}]
                ...     tag=${tags}[${i}]
                ...     expected_languages=${expecteds_languages}[${i}]
       END
    END
    ${ok_total}    Evaluate    ${ok_tc} + ${ok_missing}
    Put Note To Excel    cnt_ok=${ok_missing}    cnt_total=${ok_total}
    Put Note To Excel    cnt_ok=${ok_tc}         cnt_total=${ok_total}    ws_name=${excel_list}
    Save Test Case Excel

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
    ${ok_total}    Evaluate    ${ok} + ${nok}
    Put Note To Excel    cnt_ok=${ok}    cnt_total=${ok_total}    ws_name=${excel_list}
    Save Test Case Excel

Report rules with missing examples
    [Documentation]   Only report rules with missing examples
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
    ${ok_total}    Evaluate    ${ok} + ${nok}
    Put Note To Excel    cnt_ok=${ok}    cnt_total=${ok_total}
    Save Test Case Excel

Load particular example To Excel
    Admin Login If Necessary
    ${True}    ${final_langs}    ${before_ex}    ${after_ex}  Get Link Detail    197    Czech (academic rules), Danish, German (Germany)
    Log    ${after_ex}
    ${after_ex_nbspace}=    Format nbspace Character    ${after_ex}
    Log    ${after_ex_nbspace}
    Create New Excel List In Excel    TestSample    ${False}
    ${cnt}=  Get length   ${final_langs}
    FOR    ${i}    IN RANGE   ${cnt}
        Log    ${final_langs}[${i}] | ${before_ex}[${i}] | ${after_ex_nbspace}[${i}]
    END
    Add Table To Excel    ${final_langs}    ${before_ex}    ${after_ex_nbspace}
    Save Test Case Excel

