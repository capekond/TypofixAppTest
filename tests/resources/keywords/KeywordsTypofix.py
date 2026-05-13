import json
import os
import re
from datetime import datetime

from openpyxl import load_workbook



class KeywordsTypofix(object):
    def __init__(self):
        self.TEST_DATA_DIR = os.path.join(os.getcwd(),  'tests', 'resources', 'test_data')
        self.HTML_TAGS = ['<br>', '<p>', '<span>']
        data_store = load_workbook(os.path.join(self.TEST_DATA_DIR, "DataStore.xlsx"))
        self.data_store_list = data_store.copy_worksheet(data_store["_pattern"])
        self.data_store_list.title = datetime.now().strftime('%Y-%m-%d_%H_%M_%S')
        self.data_store_offset = 2

    def data_store_add_item (self, name, value, new_line=False, html_tag_cleanup=False):
        col = 1
        while self.data_store_list.cell(1,col).value:
            if str(self.data_store_list.cell(1,col).value).strip().lower() == name.lower():
                clean_value = self.str_cleanup(value, self.HTML_TAGS) if html_tag_cleanup else value
                self.data_store_list.cell(self.data_store_offset, col).value = clean_value
                break
            col+=1
        self.data_store_offset = self.data_store_offset + 1 if new_line else self.data_store_offset

    def data_store_save(self):
        self.data_store_list.parent.save(os.path.join(self.TEST_DATA_DIR, "DataStore.xlsx"))

    def str_cleanup(self, v:str, cleaned, cleaning='', case_sensitive=True, html_pairs=True) -> str:
        for tag in cleaned:
            v = re.sub(tag, cleaning, v, flags=re.IGNORECASE) if case_sensitive else re.sub(tag, cleaning, v)
            if html_pairs:
                tag_end = tag[:1] + '/' + tag[1:]
                v = re.sub(tag_end, '', v, flags=re.IGNORECASE) if case_sensitive else re.sub(tag_end, '', v)
        return v

    def get_json_reference_file(self, file_name: str) -> dict:
        json_file_path = os.path.join(self.TEST_DATA_DIR, 'references' , file_name + ".json")
        return json.load(open(json_file_path))

