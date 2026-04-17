*** Variables ***
# Environment Settings
${BASE_URL}                https://www.typofix.org/
#${API_BASE_URL}            https://api.typofix.org/v1
${BROWSER}                 headlesschrome

# Timeouts
${IMPLICIT_TIMEOUT}        30s
${EXPLICIT_TIMEOUT}        10s
${PAGE_LOAD_TIMEOUT}       15s

# Test Data Paths
${TEST_DATA_DIR}           ${CURDIR}/../test_data
${RESOURCES_DIR}           ${CURDIR}/../resources

# Email Configuration (if needed)
${TEST_EMAIL}              test@typofix.org
${TEST_EMAIL_DOMAIN}       typofix.org

# Default Headers for API
${DEFAULT_HEADERS}         {'Content-Type': 'application/json', 'Accept': 'application/json'}

# Environment Type
${ENV}                     test
${DEBUG_MODE}              false