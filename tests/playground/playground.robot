*** Settings ***
Library    ../resources/keywords/KeywordsTypofix.py


*** Test Cases ***
Data store File Add List
    FOR    ${i}    IN RANGE     1    5

        Data Store Add Item     name    Some rule name ${i}
        Data Store Add Item     text before    <br>Line</br> before ${i}  html_tag_cleanup=True
        Data Store Add Item     text after    <br>Line</br> <br> Line</BR> <br>Line </Br> after ${i}    new_line=True  html_tag_cleanup=True
    END
    Data Store Save



