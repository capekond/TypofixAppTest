*** Variables ***
# Valid User Data
${VALID_USER_ID}           1
${VALID_USER_EMAIL}        validuser@typofix.org
${VALID_USER_PASSWORD}     ValidPassword123!

# User Objects for Testing
${NEW_USER_DATA}           {
...                        "email": "newuser@typofix.org",
...                        "name": "New User",
...                        "password": "NewPassword123!",
...                        "role": "user"
...                        }

${UPDATE_USER_DATA}        {
...                        "name": "Updated User",
...                        "email": "updated@typofix.org"
...                        }

${INVALID_USER_DATA}       {
...                        "email": "invalid-email",
...                        "name": "",
...                        "password": "123"
...                        }

# Test Users for Various Scenarios
${ADMIN_USER}              {"email": "admin@typofix.org", "role": "admin"}
${BASIC_USER}              {"email": "basic@typofix.org", "role": "user"}
${PREMIUM_USER}            {"email": "premium@typofix.org", "role": "premium"}

# Credentials
${VALID_USERNAME}          validuser@typofix.org
${VALID_PASSWORD}          ValidPassword123!
${INVALID_USERNAME}        invaliduser@typofix.org
${INVALID_PASSWORD}        WrongPassword123!