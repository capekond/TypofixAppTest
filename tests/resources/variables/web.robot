*** Variables ***
${WEB_BASE_URL}   https://www.typofix.org/application

# Login Page Locators
${EMAIL}               ocapek@gmail.com
${LOGIN_BUTTON}        xpath://button[@type='submit']

# Homepage Locators
${LANGUAGE}               id:language-select
${REFERENCE_SET}          id:preference-set-select
${INPUT}                  //*[@role="textbox"]
${INPUT_INNER}            //*[@role="textbox"]/p/span/span/span
${INPUT_INNER_EMPTY}      //*[@role="textbox"]/p/span/span/span[1]

${TYPOFIX}                //*[@title="Typofix"]

#//*[@id="root"]/div/main/div/div[1]/div[1]/div/div[2]/p/span/span/span/text()
