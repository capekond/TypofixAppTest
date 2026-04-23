*** Variables ***
${WEB_BASE_URL}   https://www.typofix.org/application#testing

# Login Page Locators
${EMAIL}               ocapek@gmail.com
${LOGIN_BUTTON}        xpath://button[@type='submit']

# Homepage Locators
${LANGUAGE}               id:language-select
${REFERENCE_SET}          id:preference-set-select
${INPUT_INNER}            //*[@role="textbox"]/p/span/span/span
${TYPOFIX}                //*[@title="Typofix"]
${REPLACE}                xpath://button[text()='Replace']
${REPLACEMENTS}           class:replacements-item