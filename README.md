USE 
mcrypt secret.robot
mcrypt -d secret.robot.nc

# Robot Framework Test Suites Documentation

This README provides comprehensive documentation for the Robot Framework test suites that are designed to test the functionalities of the Typofix application, including web browser and REST API tests.

## Overview

Robot Framework is a generic automation framework that is used for test automation and robotic process automation (RPA). This documentation covers the following aspects:
- Web Browser Testing
- REST API Testing
- Test Suites Structure
- Running Tests

## 1. Web Browser Testing

### 1.1 Description
The web browser testing suite is designed to automate browser interactions to validate the user interface and functionality of the Typofix application.

### 1.2 Libraries Used
- **SeleniumLibrary**: This library provides a convenient API for conducting tests using web browsers.

### 1.3 Example Test Case
```robot
*** Test Cases ***
Test Typofix Homepage
    [Documentation]    Validate that the homepage loads correctly.
    Open Browser    https://www.typofix.org/    chrome
    Page Should Contain    Typofix
    Close Browser
```

## 2. REST API Testing

### 2.1 Description
This suite focuses on testing the REST API endpoints provided by the Typofix application to ensure they respond correctly with the expected data.

### 2.2 Libraries Used
- **RequestsLibrary**: This library is used to make HTTP requests to validate API endpoints.

### 2.3 Example Test Case
```robot
*** Test Cases ***
Test Get All Items API
    [Documentation]    Validate the GET API is working as expected.
    Create Session    typofix    https://api.typofix.org/
    GET Request    typofix    /items
    Status Should Be    200
```

## 3. Test Suites Structure

The test suites structure can be organized into separate folders for web and API tests. For example:
```
/tests
    /web
        |-- web_tests.robot
    /api
        |-- api_tests.robot
```

## 4. Running Tests

To run the tests, ensure you have Robot Framework and the necessary libraries installed:
```bash
pip install robotframework selenium robotframework-requests
```

Execute the tests using the command:
```bash
robot tests/web/web_tests.robot
```

## Conclusion

This documentation serves as a starting point for understanding and executing the Robot Framework test suites for the Typofix application. For additional information on the Robot Framework, refer to the [Robot Framework User Guide](https://robotframework.org/).