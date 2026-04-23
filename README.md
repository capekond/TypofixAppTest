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
## Test execution and reporting 

Reporting is available as html local file <projects folder>/TypofixAppTest/results/report.html
 