# Robot Framework Test Suites Documentation for Typofix application

There are test for https://www.typofix.org/application

## Before Running Tests
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
## How to setup test functional scope
There are 2 possibilities to set up the scope. The differences depend on used data file with definition of Test Cases
### Excel file

Excel file sample is here https://github.com/capekond/TypofixAppTest/blob/main/tests/resources/test_data/TestCases.xlsx To execute test leave https://github.com/capekond/TypofixAppTest/blob/main/tests/web/data_driven.robot as it is

### csv files UTF-8
- pipeline delimiter
  - csv file is here https://github.com/capekond/TypofixAppTest/blob/main/tests/resources/test_data/TestCasesPipe.csv  
  - enable https://github.com/capekond/TypofixAppTest/blob/main/tests/web/data_driven.robot#L4
- semicolon delimiter
  - csv file is here https://github.com/capekond/TypofixAppTest/blob/main/tests/resources/test_data/TestCasesSemicolon.csv
  - enable https://github.com/capekond/TypofixAppTest/blob/main/tests/web/data_driven.robot#L5
  - change https://github.com/capekond/TypofixAppTest/blob/main/tests/web/data_driven.robot#L2
  ```bash
  ${CSV_DELIMITER}    ;
  ```
## Test execution and reporting 

For now test execution is done from Pycharm tool.

Reporting is available as html local file <projects folder>/TypofixAppTest/results/report.html

# TODO
- enlarge the scope 
- prove that special characters are correctly handled 
- add doc for execution
  - local python setup and run
  - CI/CD pipeline https://docs.robotframework.org/docs/using_rf_in_ci_systems/ci/github-actions
  - run from container 
