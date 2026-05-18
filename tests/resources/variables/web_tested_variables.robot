*** Variables ***
${TESTED_BASE_URL}   https://www.typofix.org/application#testing
${ADMIN_BASE_URL}    https://typofix.slonline.sk/admin/


# Homepage Locators for tested
${LANGUAGE}               id:language-select
${REFERENCE_SET}          id:preference-set-select
${INPUT_INNER}            //*[@role="textbox"]/p/span/span/span
${OUTPUT_INNER}            //*[@role="textbox"]
${TYPOFIX}                //*[@title="Run Typofix"]
${REPLACE}                xpath://button[text()='Replace']
${REPLACEMENTS}           class:replacements-item

# Homepage Locators for admin
${ADMIN_TABLE_TEXT_REPLACE}       //table[@class="table grid-field__table"]/tbody/tr
${ADMIN_GO_BACK}                  //*[@id="Form_ItemEditForm"]/div[1]/div[1]/a
${ADMIN_BEFORE_TEXT_REPLACE}      xpath://textarea[@name='ExampleBefore']
${ADMIN_AFTER_TEXT_REPLACE}       xpath://textarea[@name='ExampleAfter']
${ADMIN_NEXT}                     xpath://button[@value='Next']
${ADMIM_PG_INFO}                  xpath://span[@class='pagination-page-number']