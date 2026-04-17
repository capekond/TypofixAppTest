*** Variables ***
${WEB_BASE_URL}   https://www.typofix.org/application

# Login Page Locators
${EMAIL}               ocapek@gmail.com
${LOGIN_BUTTON}        xpath://button[@type='submit']







# Homepage Locators
${MAIN_HEADER}            xpath://header[@class='main-header']
${NAVBAR}                 xpath://nav[@class='navbar']
${HOME_LINK}              xpath://a[contains(text(), 'Home')]
${SEARCH_LINK}            xpath://a[contains(text(), 'Search')]
${ABOUT_LINK}             xpath://a[contains(text(), 'About')]
${CONTACT_LINK}           xpath://a[contains(text(), 'Contact')]
${FEATURED_SECTION}       xpath://section[@class='featured']
${FEATURED_ITEMS}         xpath://section[@class='featured']//article

# Search Page Locators
${SEARCH_WIDGET}          xpath://div[@class='search-widget']
${SEARCH_INPUT}           id:search-input
${SEARCH_BUTTON}          xpath://button[contains(@class, 'search-button')]
${SEARCH_RESULTS}         xpath://div[@class='search-results']
${NO_RESULTS_MESSAGE}     xpath://div[@class='no-results']
${SORT_DROPDOWN}          xpath://select[@id='sort-by']
${PAGINATION_NEXT}        xpath://a[@rel='next']
${PAGINATION_INFO}        xpath://div[@class='pagination-info']

# Social Media Links
${FACEBOOK_LINK}          xpath://a[@data-social='facebook']
${TWITTER_LINK}           xpath://a[@data-social='twitter']
${LINKEDIN_LINK}          xpath://a[@data-social='linkedin']

# Common Locators
${DASHBOARD}              xpath://div[@class='dashboard']
${USER_MENU}              xpath://div[@class='user-menu']
${MODAL_DIALOG}           xpath://div[@role='dialog']
${LOADING_SPINNER}        xpath://div[@class='spinner']