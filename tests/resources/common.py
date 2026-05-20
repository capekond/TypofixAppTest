import os
from pathlib import Path

class Common:
    def __init__(self):
        self.RESOURCES_DIR = Path(__file__).parent
        self.DATA_STORE_FILE = os.path.join(self.RESOURCES_DIR, "test_data", "DataStore.xlsx")
        self.TEST_CASES_FILE = os.path.join(self.RESOURCES_DIR, "test_data", "TestCases.xlsx")
        self.LANGUAGES_FILE = os.path.join(self.RESOURCES_DIR, 'test_data', 'references', '_list.csv')
        self.HTML_TAGS = ['<br>', '<p>', '<span>']
        self.PATTERN = "_pattern"
        self.CLEAN_CHAR = '_'
        self.REPORT_FILE = os.path.join(self.RESOURCES_DIR.parent.parent, 'results', 'output.xml')
