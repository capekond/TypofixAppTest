*** Variables ***
${WEB_BASE_URL}   https://www.typofix.org/application#testing

# Homepage Locators
${LANGUAGE}               id:language-select
${REFERENCE_SET}          id:preference-set-select
${INPUT_INNER}            //*[@role="textbox"]/p/span/span/span
${TYPOFIX}                //*[@title="Typofix"]
${REPLACE}                xpath://button[text()='Replace']
${REPLACEMENTS}           class:replacements-item