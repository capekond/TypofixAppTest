import json
import os
import re
from datetime import datetime
import pandas as pd
from openpyxl import load_workbook
from tests.resources.common import Common


class KeywordsTypofix(object):
    def __init__(self):
        self.cp = Common()
        data_store = load_workbook(self.cp.DATA_STORE_FILE)
        self.data_store_list = data_store.copy_worksheet(data_store[self.cp.PATTERN])
        self.data_store_list.title = datetime.now().strftime('%Y-%m-%d_%H_%M_%S')
        self.data_store_offset = 2

    def data_store_add_item (self, name, value, new_line=False, html_tag_cleanup=False):
        col = 1
        while self.data_store_list.cell(1,col).value:
            if str(self.data_store_list.cell(1,col).value).strip().lower() == name.lower():
                clean_value = self.str_cleanup(value, self.cp.HTML_TAGS) if html_tag_cleanup else value
                self.data_store_list.cell(self.data_store_offset, col).value = clean_value
                break
            col+=1
        self.data_store_offset = self.data_store_offset + 1 if new_line else self.data_store_offset

    def data_store_save(self):
        self.data_store_list.parent.save(self.cp.DATA_STORE_FILE)

    def str_cleanup(self, v:str, cleaned, cleaning='', case_sensitive=True, html_pairs=True) -> str:
        for tag in cleaned:
            v = re.sub(tag, cleaning, v, flags=re.IGNORECASE) if case_sensitive else re.sub(tag, cleaning, v)
            if html_pairs:
                tag_end = tag[:1] + '/' + tag[1:]
                v = re.sub(tag_end, '', v, flags=re.IGNORECASE) if case_sensitive else re.sub(tag_end, '', v)
        return v

    def get_json_reference_file(self, file_name: str) -> dict:
        #todo delete
        file_name = file_name if file_name.endswith('.json') else file_name + '.json'
        json_file_path = os.path.join(self.cp.RESOURCES_DIR, 'test_data' , 'references', file_name)
        return json.load(open(json_file_path))

    def get_field_for_language_from_reference(self, language: str, field: str) -> str:
        df = pd.read_csv(self.cp.LANGUAGES_FILE, sep=';').query(f"language == '{language}'")
        return df[field].values[0]

    def get_column_from_reference(self, column) -> list:
        df = pd.read_csv(self.cp.LANGUAGES_FILE, sep=';')
        return df[column].values

    def write_value_to_TC_by_test_name(self, test_name: str, field_name: str, value, override=False) -> None:
        wb = load_workbook(self.cp.DATA_STORE_FILE)
        sh = wb.active
        r, c = self.cp.get_position_by_name_and_value(sh, "Test Cases", test_name)
        c = self.cp.get_column_by_name(sh, field_name)
        sh.cell(r, c).value = value
        wb.save(self.cp.DATA_STORE_FILE)



tp = KeywordsTypofix()
wb = load_workbook(tp.cp.TEST_CASES_FILE)
ws = wb.active
print(tp.cp.get_position_by_name_and_value(ws, "Test Cases","44. Guns N’ Roses [Czech (academic rules)]" ))
print(tp.get_field_for_language_from_reference("Czech (traditional rules)", "name"))
# print(tp.write_value_to_TC_by_test_name("66. Correct form of et al. [Czech (academic rules)]", "fixes_count", 10))
