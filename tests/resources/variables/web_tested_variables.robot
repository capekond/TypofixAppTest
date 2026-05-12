*** Variables ***
${TESTED_BASE_URL}   https://www.typofix.org/application#testing
${ADMIN_BASE_URL}    https://typofix.slonline.sk/admin/


# Homepage Locators for tested
${LANGUAGE}               id:language-select
${REFERENCE_SET}          id:preference-set-select
${INPUT_INNER}            //*[@role="textbox"]/p/span/span/span
${TYPOFIX}                //*[@title="Run Typofix"]
${REPLACE}                xpath://button[text()='Replace']
${REPLACEMENTS}           class:replacements-item

# Homepage Locators for admin
${ADMIN_EMAIL}
${ADMIN_PASSWORD}