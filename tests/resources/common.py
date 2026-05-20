import os
from pathlib import Path

class Common:
    def __init__(self):

        self.RESOURCES_DIR = Path(__file__).parent
        self.TEST_DATA_DIR = os.path.join(self.RESOURCES_DIR, "test_data")
        self.PCX_DIR = os.path.join(self.TEST_DATA_DIR, "pcx_dir")
        self.REPORT_DIR = os.path.join(self.RESOURCES_DIR.parent.parent, 'results')

        self.DATA_STORE_FILE = os.path.join(self.TEST_DATA_DIR, "DataStore.xlsx")
        self.TEST_CASES_FILE = os.path.join(self.TEST_DATA_DIR, "TestCases.xlsx")
        self.LANGUAGES_FILE = os.path.join(self.TEST_DATA_DIR, 'references', '_list.csv')
        self.REPORT_FILE = os.path.join(self.REPORT_DIR,'output.xml')

        self.HTML_TAGS = ['<br>', '<p>', '<span>']
        self.PATTERN = "_pattern"
        self.CLEAN_CHAR = '_'
