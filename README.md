# Playwright Test Suites Documentation for Typofix Application

Tests for https://www.typofix.org/application

## Before Running Tests

### General Prerequisites

Check that Python 3.12+ (3.14 recommended) is installed on your computer:

```bash
python -V
# Python 3.14.3
```

If not installed, download from https://www.python.org/downloads/

Clone the repository:

```bash
git clone https://github.com/capekond/TypofixAppTest.git
cd TypofixAppTest
```

### Specific Setup for Project

1. **Install dependencies:**

```bash
pip install -r requirements.txt
```

2. **Install Playwright browsers:**

```bash
playwright install chromium
```

3. **Decrypt credentials file:**

```bash
cd tests/resources/variables/
mcrypt -d secret.robot.nc
```

4. **Verify Playwright installation:**

```bash
playwright --version
# Version 1.45.0
```

## Running Tests

### General Information

Playwright generates HTML reports automatically. Test results are saved in the `results/` directory.

### Test Workflow

#### 1. Load Examples from Admin Application

Loads defined text-replace examples from the admin panel and builds Excel test cases:

```bash
pytest tests/web/test_load_excel.py -v
```

**Output includes:**
- Excel file populated with rule IDs, names, languages, and expected transformations
- Test data stored in `tests/resources/test_data/TestCases.xlsx`

#### 2. Prepare Test Cases

Transfers data from the DataStore Excel file to the TestCase Excel file:

```bash
python tools/transfer_data_store_to_TC.py
```

**Interactive prompt:**
- Confirms source and target worksheets
- Transfers and formats data

#### 3. Execute Tests

Runs all test cases from the Excel file against the Typofix application:

```bash
pytest tests/web/test_execute_excel.py -v
```

**Output includes:**
- Detailed test results with assertions
- Screenshots on failure
- Results added back to Excel file
- HTML report generated in `results/` directory

### Example Command Sequence

```bash
# Install dependencies
pip install -r requirements.txt
playwright install chromium

# Run load test
pytest tests/web/test_load_excel.py -v

# Prepare data
python tools/transfer_data_store_to_TC.py

# Execute main tests
pytest tests/web/test_execute_excel.py -v

# View results
# Open results/report.html in your browser
```

## Project Structure

```
TypofixAppTest/
├── tests/
│   ├── web/
│   │   ├── test_execute_excel.py    # Main test execution
│   │   └── test_load_excel.py       # Load test data from admin
│   └── resources/
│       ├── fixtures/
│       │   └── browser_fixtures.py  # Browser setup/teardown
│       ├── helpers/
│       │   └── typofix_helpers.py   # Utility functions for Excel and Typofix
│       ├── test_data/
│       │   └── TestCases.xlsx       # Test cases and results
│       └── variables/
│           └── secret.robot         # Credentials (encrypted)
├── tools/
│   ├── transfer_data_store_to_TC.py # Transfer DataStore to TestCases
│   └── add_results_to_TC.py         # Update TestCases with results
├── results/                          # Test reports and output
├── requirements.txt
└── README.md
```

## Key Features

- **Data-Driven Testing:** Tests load parameters from Excel files
- **Browser Automation:** Uses Playwright for reliable cross-browser testing
- **Excel Integration:** Manages test data and results in Excel workbooks
- **Admin Panel Integration:** Automatically loads rule definitions from admin interface
- **Detailed Reporting:** Generates HTML reports with screenshots on failures
- **Flexible Language Support:** Tests multiple language configurations

## Troubleshooting

### Browser Installation Issues

```bash
playwright install --with-deps chromium
```

### Permission Denied on Tools

```bash
chmod +x tools/*.py
```

### Excel File Locked

Ensure no other processes have the Excel files open.

### Test Data Not Loading

Verify the `TestCases.xlsx` file exists and is properly formatted.

## TODO

- Add CI/CD pipeline integration (GitHub Actions)
- Run tests in Docker containers
- Enhanced error handling and logging
- Performance optimization for large datasets
- Support for additional browsers (Firefox, Safari)

## Documentation Links

- [Playwright Documentation](https://playwright.dev/python/)
- [Pytest Documentation](https://docs.pytest.org/)
- [GitHub Actions for Testing](https://docs.github.com/en/actions)
