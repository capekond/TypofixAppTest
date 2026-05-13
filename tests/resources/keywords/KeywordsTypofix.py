import json
import os
from datetime import datetime

from openpyxl import load_workbook



class KeywordsTypofix(object):
    def __init__(self):
        self.TEST_DATA_DIR = os.path.join(os.getcwd(),  'tests', 'resources', 'test_data')
        data_store = load_workbook(os.path.join(self.TEST_DATA_DIR, "DataStore.xlsx"))
        self.data_store_list = data_store.copy_worksheet(data_store["_pattern"])
        self.data_store_list.title = datetime.now().strftime('%Y-%m-%d_%H_%M_%S')
        self.data_store_offset = 2

    def data_store_add_item (self, name, value, new_line=False):
        col = 1
        while self.data_store_list.cell(1,col).value:
            if str(self.data_store_list.cell(1,col).value).strip().lower() == name.lower():
                self.data_store_list.cell(self.data_store_offset, col).value = value
                break
            col+=1
        self.data_store_offset = self.data_store_offset + 1 if new_line else self.data_store_offset

    def data_store_save(self):
        self.data_store_list.parent.save(os.path.join(self.TEST_DATA_DIR, "DataStore.xlsx"))

    def get_json_reference_file(self, file_name: str) -> dict:
        json_file_path = os.path.join(self.TEST_DATA_DIR, 'references' , file_name + ".json")
        return json.load(open(json_file_path))
