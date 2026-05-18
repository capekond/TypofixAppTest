import json
import os
import re
from datetime import datetime
import pandas as pd
from openpyxl import load_workbook
from pathlib import Path

from openpyxl.worksheet.worksheet import Worksheet


class KeywordsTypofix(object):
    def __init__(self):
        self.RESOURCES_DIR = Path(__file__).parent.parent
        self.HTML_TAGS = ['<br>', '<p>', '<span>']
        data_store = load_workbook(os.path.join(self.RESOURCES_DIR, "test_data","DataStore.xlsx"))
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
        self.data_store_list.parent.save(os.path.join(self.RESOURCES_DIR, "test_data", "DataStore.xlsx"))

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
        json_file_path = os.path.join(self.RESOURCES_DIR, 'test_data' , 'references', file_name)
        return json.load(open(json_file_path))

    def get_field_for_language_from_reference(self, language: str, field: str) -> str:
        f_name = os.path.join(self.RESOURCES_DIR, 'test_data'  , 'references', '_list.csv')
        df = pd.read_csv(f_name, sep=';').query(f"language == '{language}'")
        return df[field].values[0]

    def get_column_from_reference(self, column) -> list:
        f_name = os.path.join(self.RESOURCES_DIR, 'test_data', 'references', '_list.csv')
        df = pd.read_csv(f_name, sep=';')
        return df[column].values

    def write_value_to_TC_by_test_name(self, test_name: str, field_name: str, value, override=False) -> None:
        wb = load_workbook(os.path.join(self.RESOURCES_DIR, "test_data", "TestCases.xlsx"))
        sh = wb.active
        r, c = self.get_position_by_name_and_value(sh, "Test Cases", test_name)
        c = self.get_column_by_name(sh, field_name)
        sh.cell(r, c).value = value
        wb.save(os.path.join(self.RESOURCES_DIR, "test_data", "TestCases.xlsx"))

    def get_position_by_name_and_value(self, sh: Worksheet, field_name: str, field_value: str, contains_name=True) -> (int, int):
        r = 0
        c = self.get_column_by_name(sh, field_name, contains_name)
        for row in range(2, sh.max_row):
            cv = sh.cell(row,c).value
            if (contains_name and cv in field_value) or (not contains_name and cv == field_value):
                    r = row
                    break
        return r, c

    def get_column_by_name(self, sh: Worksheet, field_name, contains_name=True) -> int:
        c = 0
        for col in range(1, sh.max_column+1):
            cv = sh.cell(1,col).value
            if (contains_name and field_name in cv) or (not contains_name and cv == field_name):
                    c = col
                    break
        return c

# tp = KeywordsTypofix()
# wb = load_workbook(os.path.join(tp.RESOURCES_DIR, "test_data", "TestCases.xlsx"))
# ws = wb.active
# print(tp.get_position_by_name_and_value(ws, "Test Cases","44. Guns N’ Roses [Czech (academic rules)]" ))
# print(tp.get_position_by_name_and_value(ws,"Test Cases", "66. Correct form of et al. [Czech (academic rules)]" ))
# print(tp.write_value_to_TC_by_test_name("66. Correct form of et al. [Czech (academic rules)]", "fixes_count", 10))
