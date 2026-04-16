*** Variables ***
# Search Terms
${SEARCH_TERM_BASIC}       typofix
${SEARCH_TERM_ADVANCED}    grammar correction
${SEARCH_TERM_NONEXISTENT} xyzabc12345nonexistent

# Filter Data
${FILTER_CATEGORY}         category
${FILTER_VALUE}            documentation
${FILTER_DATE}             2024-01-01

# Sort Options
${SORT_BY_RELEVANCE}       Relevance
${SORT_BY_DATE}            Date
${SORT_BY_POPULARITY}      Popularity
${SORT_ORDER_ASC}          asc
${SORT_ORDER_DESC}         desc

# Pagination
${PAGE_SIZE}               10
${DEFAULT_OFFSET}          0

# Expected Results Count
${MIN_RESULTS_COUNT}       1
${MAX_RESULTS_COUNT}       100