*** Settings ***
Library    ../resources/keywords/KeywordsTypofix.py


*** Test Cases ***
Data store File Add List
    Data Store Create List
    FOR    ${i}    IN RANGE     1    3
        Data Store New Line
        Data Store Add Item     name    Some rule name ${i}
        Data Store Add Item     before    Line before ${i}
        Data Store Add Item     after    Line after ${i}
    END
    Data Store Save




