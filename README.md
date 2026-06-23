# Robot Framework Test Suites Documentation for Typofix application

## Before Running Tests

### General prerequisites 
Check that python 3.14  is installed on your computer
```bash
C:\Users\theuser>python -V
Python 3.14.3
```
If not install it from https://www.python.org/downloads/

Clone repository from https://github.com/capekond/TypofixAppTest to to selected local project folder. C:\Users\theuser\IdeaProjects\ is used for this documentation
### Specific setup for project 
1. execute requirements 
```bash
cd <project folder>/TypofixAppTest/
pip install  -r  requirements.txt
```
2. decrypt file with credentials:
```bash
cd <projects folder>/TypofixAppTest/tests/resources/variables/
mcrypt -d secret.robot.nc
```
3. check robot framework version. In case of problem, here is detailed approach for  previous steps https://robotframework.org/robotframework/latest/RobotFrameworkUserGuide.html#installation-instructions
```bash
C:\Users\theuser>python -m robot --version
Robot Framework 7.4.2 (Python 3.14.3 on win32)
```
# Running test
## General information
When run *.robot file C:\Users\theuser\report.html contains the HTML with test  results. Open it in local browser
## Prepare the test scope
```bash
C:\Users\theuser> python -m robot --include complete C:\Users\theuser\IdeaProjects\TypofixAppTest\tests\web\load_excel.robot 

````
File C:\Users\theuser\IdeaProjects\TypofixAppTest\tests\resources\test_data\TestCases.xlsx
- new worksheet at left of test cases is added
- updated   

Possible output in cmd line:
```bash
==============================================================================
Load Excel
==============================================================================
Load defined examples to test cases and report rules with missing ... .Test Case load starting
.Login, session created
Add Test Case 2 Keep date and month name together (2 May) Bulgarian, Dutch, English (UK), English (US), French, Greek, Irish, Italian, Maltese, Polish, Romanian, Spanish, Swedish
Add Test Case 379 Replace colon in time values by period after time related prepositions (around 10:00 → around 10.00) Czech (academic rules), Czech (traditional rules), Slovenian
Add Test Case 380 Replace colon in time values by period when followed by word “hour” (10:00 hod. to 10.00 hod.) Czech (academic rules), Czech (traditional rules), Hungarian, Slovenian
...
...
469/471 "test info: Use comma as a decimal separator after currency symbols (€ 19,90) Has examples: False Languages: None Before: None After: None
470/471 "test info: Nonbreaking space between value and local currency word (20 dollars) Has examples: False Languages: None Before: None After: None
Load defined examples to test cases and report rules with missing ... | PASS |
------------------------------------------------------------------------------
Load Excel                                                            | PASS |
1 test, 1 passed, 0 failed
==============================================================================
Output:  C:\Users\theuser\output.xml
Log:     C:\Users\theuser\log.html
Report:  C:\Users\theuser\report.html

```
## Execute tests 
Execute test cases in first list of Excel TesCase file
```bash
C:\Users\theuser>python -m robot C:\Users\theuser\IdeaProjects\TypofixAppTest\tests\web\tt_execute_excel.robot
```
File C:\Users\theuser\IdeaProjects\TypofixAppTest\tests\resources\test_data\TestCases.xlsx
- add test result to the worksheet 

Possible output:
```bash
==============================================================================
Tt Execute Excel
==============================================================================
2_Keep_date_and_month_name_together_2_May_Bulgarian :: Insert a no... Login, session created
2_Keep_date_and_month_name_together_2_May_Bulgarian :: Insert a no... | PASS |
------------------------------------------------------------------------------
2_Keep_date_and_month_name_together_2_May_Dutch :: Insert a nonbre... Reuse open session
2_Keep_date_and_month_name_together_2_May_Dutch :: Insert a nonbre... | PASS |
------------------------------------------------------------------------------
2_Keep_date_and_month_name_together_2_May_English_UK :: Insert a n... Reuse open session
2_Keep_date_and_month_name_together_2_May_English_UK :: Insert a n... | PASS |
------------------------------------------------------------------------------
...
...
425_Nonbreaking_space_between_numbers_and_non_SI_single_letter_uni... Reuse open session
425_Nonbreaking_space_between_numbers_and_non_SI_single_letter_uni... | PASS |
------------------------------------------------------------------------------
426_Thin_space_between_numbers_and_non_SI_single_letter_units_24_h... Reuse open session
426_Thin_space_between_numbers_and_non_SI_single_letter_units_24_h... | PASS |
------------------------------------------------------------------------------
Tt Execute Excel                                                      | PASS |
326 tests, 326 passed, 0 failed
==============================================================================
Output:  C:\Users\ocape\output.xml
Log:     C:\Users\ocape\log.html
Report:  C:\Users\ocape\report.html
```
# TODO
https://github.com/capekond/TypofixAppTest/issues
- prove that special characters are correctly handled 
- add CI/CD pipeline https://docs.robotframework.org/docs/using_rf_in_ci_systems/ci/github-actions