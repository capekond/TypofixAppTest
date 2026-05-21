# Robot Framework Test Suites Documentation for Typofix application

There are test for https://www.typofix.org/application

## Before Running Tests

### General prerequisites 
Check that python 3.14 (recommended version, 3.12 should be ok) is installed on your computer
```bash
C:\Users\theuser>python -V
Python 3.14.3
```
If not install it from https://www.python.org/downloads/

Clone repository from https://github.com/capekond/TypofixAppTest to to selected local project folder
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
Command:
```bash
C:\Users\theuser> python -m robot C:\Users\ocape\IdeaProjects\TypofixAppTest\tests\web\admin_application.robot

````
Possible output:
```bash
==============================================================================
Admin Application
==============================================================================
Add defined examples to data store :: Build data store                Login, session created
44
Guns N’ Roses
Czech (academic rules), Czech (traditional rules), English, English (UK), English (US), German (Germany), Spanish
45
Correct form of C. a K. in Czech
Czech (academic rules), Czech (traditional rules)
46

Add defined examples to data store :: Build data store                | PASS |
------------------------------------------------------------------------------
Admin Application                                                     | PASS |
1 test, 1 passed, 0 failed
==============================================================================
Output:  C:\Users\ocape\output.xml
Log:     C:\Users\ocape\log.html
Report:  C:\Users\ocape\report.html
```
Transfer data
```bash
C:\Users\theuser> python C:\Users\ocape\IdeaProjects\TypofixAppTest\tools\transfer_data_store_to_TC.py
```
Possible output:
```bash
Content of last list from C:\Users\ocape\IdeaProjects\TypofixAppTest\tests\resources\test_data\DataStore.xlsx will be formatted and transferred to C:\Users\ocape\IdeaProjects\TypofixAppTest\tests\resources\test_data\TestCases.xlsx
For more info let try --help
Do you like to proceed the task? [Y/n]  Y
Selected source worksheet 2026-05-21_09_24_48
Selected target worksheet tc_A5
```
## Execute tests 
Command:
```bash
C:\Users\theuser> python -m robot C:\Users\ocape\IdeaProjects\TypofixAppTest\tests\web\tested_app_prepare_excel.robot
```
Possible output:
```bash
==============================================================================
Tested App Prepare Excel
==============================================================================
44__Guns_N__RosesCzech__academic_rules_                               Login, session created
44__Guns_N__RosesCzech__academic_rules_                               | PASS |
------------------------------------------------------------------------------
44__Guns_N__RosesCzech__traditional_rules_                            Reuse open session
44__Guns_N__RosesCzech__traditional_rules_                            | PASS |
------------------------------------------------------------------------------
45__Correct_form_of_C__a_K__in_CzechCzech__academic_rules_            Reuse open session
45__Correct_form_of_C__a_K__in_CzechCzech__academic_rules_            | PASS |
------------------------------------------------------------------------------
45__Correct_form_of_C__a_K__in_CzechCzech__traditional_rules_         Reuse open session
45__Correct_form_of_C__a_K__in_CzechCzech__traditional_rules_         | PASS |
------------------------------------------------------------------------------
Tested App Prepare Excel                                              | PASS |
4 tests, 4 passed, 0 failed
==============================================================================
Output:  C:\Users\ocape\output.xml
Log:     C:\Users\ocape\log.html
Report:  C:\Users\ocape\report.html
```
Command
```bash
C:\Users\theuser> python C:\Users\ocape\IdeaProjects\TypofixAppTest\tools\add_results_to_TC.py
```
Possible output:
```bash
Results added to file C:\Users\ocape\IdeaProjects\TypofixAppTest\tests\resources\test_data\TestCases.xlsx from C:\Users\ocape\IdeaProjects\TypofixAppTest\results\output.xml

Selected 4 test cases:
44__Guns_N__RosesCzech__academic_rules_
44__Guns_N__RosesCzech__traditional_rules_
45__Correct_form_of_C__a_K__in_CzechCzech__academic_rules_
45__Correct_form_of_C__a_K__in_CzechCzech__traditional_rules_
```
# TODO
- prove that special characters are correctly handled 
- add doc for execution
  - CI/CD pipeline https://docs.robotframework.org/docs/using_rf_in_ci_systems/ci/github-actions
  - run from container