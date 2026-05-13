import json
import os
from datetime import datetime

from openpyxl import load_workbook



class KeywordsTypofix(object):
    def __init__(self):
        self.TEST_DATA_DIR = os.path.join(os.getcwd(),  'tests', 'resources', 'test_data')
        self.data_store = load_workbook(os.path.join(self.TEST_DATA_DIR, "DataStore.xlsx"))
        self.DATA_STORE_LIST = datetime.now().strftime('%Y-%m-%d_%H_%M_%S')
        self.data_store_offset = 0

    def data_store_save(self):
        self.data_store.save(os.path.join(self.TEST_DATA_DIR, "DataStore.xlsx"))

    def data_store_create_list(self):
        self.data_store_offset = 1
        data_store_ls  = self.data_store.copy_worksheet(self.data_store["_pattern"])
        data_store_ls.title = self.DATA_STORE_LIST

    def data_store_new_line (self):
        self.data_store_offset+=1

    def data_store_add_item (self, name, value):
        col = 1

        ls = self.data_store[self.DATA_STORE_LIST]
        while ls.cell(1,col).value:
            if str(ls.cell(1,col).value).strip().lower() == name.lower():
                ls.cell(self.data_store_offset, col).value = value
                break
            col+=1

    def get_json_reference_file(self, file_name: str) -> dict:
        json_file_path = os.path.join(self.TEST_DATA_DIR, 'references' , file_name + ".json")
        return json.load(open(json_file_path))
