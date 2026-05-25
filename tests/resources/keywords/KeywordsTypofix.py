import io
import json
import os

from openpyxl import load_workbook
from pathlib import Path
from openpyxl.styles import Font, colors
from openpyxl.cell.cell import Cell

class KeywordsTypofix(object):
    def __init__(self):
        self.RESOURCES_DIR = Path(__file__).parent.parent
        self.TEST_CASES_FILE = os.path.join(self.RESOURCES_DIR, "test_data", "TestCases.xlsx")
        self.TEST_CASES_WB = load_workbook(self.TEST_CASES_FILE)
        self.LANGUAGES_FILE = os.path.join(self.RESOURCES_DIR, 'test_data', 'references', '_list.csv')
        self.HTML_TAGS = ['<br>', '<p>', '<span>']
        self.PATTERN = "_pattern"
        self.CLEAN_CHAR = '_'

    def create_new_excel_list_in_excel(self) -> str:
        first = self.TEST_CASES_WB.copy_worksheet(self.TEST_CASES_WB[self.PATTERN])
        first.title = "tc_A"
        self.TEST_CASES_WB.move_sheet(first, offset=- (len(self.TEST_CASES_WB.worksheets) - 1))
        print(f"Selected target worksheet {first.title}")
        self.TEST_CASES_WB.save(self.TEST_CASES_FILE)
        return first.title

    def add_new_test_cases_to_excel(self, excel_list: str, id: str | int, name: str, url_detail: str, languages: list[str], befores:list[str], afters: list[str]):
        ws = self.TEST_CASES_WB[excel_list]
        rows = ws.max_row
        for i, language in enumerate(languages):
            test_name = self._clean_up_text(id + self.CLEAN_CHAR + name + self.CLEAN_CHAR + language)
            ws.cell(row=rows + i, column=1, value=self._clean_up_text(id + self.CLEAN_CHAR + name + self.CLEAN_CHAR + language))
            self._insert_excel_hyperlink(ws.cell(row=rows + i, column=4),id + name,url_detail)
            ws.cell(row=rows + i, column=5, value= language)
            ws.cell(row=rows + i, column=6, value=befores[i])
            ws.cell(row=rows + i, column=7, value=afters[i])
        self.TEST_CASES_WB.save(self.TEST_CASES_FILE)

    def _insert_excel_hyperlink(self, c: Cell, name: str, link: str):
        c.value = name
        c.hyperlink = self._customize_url(link)

    def _customize_url(self, url: str, pattern_name='detail') -> str:
        if pattern_name == 'detail':
            url = url[:url.index('=')]
        return url

    def _clean_up_text(self, txt: str) -> str:
        res = ""
        for t in txt:
            res += self.CLEAN_CHAR if t.isspace() or not (t.isalnum()) else t
        return res






    # def data_store_add_item (self, name, value, new_line=False, html_tag_cleanup=False):
    #     clean_value = self.str_cleanup(value, self.HTML_TAGS) if html_tag_cleanup else value
    #     self.g_rules_record[name] = clean_value
    #
    # @staticmethod
    # def str_cleanup(v:str, cleaned, cleaning='', case_sensitive=True, html_pairs=True) -> str:
    #     for tag in cleaned:
    #         v = re.sub(tag, cleaning, v, flags=re.IGNORECASE) if case_sensitive else re.sub(tag, cleaning, v)
    #         if html_pairs:
    #             tag_end = tag[:1] + '/' + tag[1:]
    #             v = re.sub(tag_end, '', v, flags=re.IGNORECASE) if case_sensitive else re.sub(tag_end, '', v)
    #     return v
    #
    # def get_json_reference_file(self, file_name: str) -> dict:
    #     #todo delete
    #     file_name = file_name if file_name.endswith('.json') else file_name + '.json'
    #     json_file_path = os.path.join(self.RESOURCES_DIR, 'test_data' , 'references', file_name)
    #     file = io.open(json_file_path, encoding="utf-8")
    #     return json.load(file)
    #
    # def get_field_for_language_from_reference(self, language: str, field: str) -> str:
    #     df = pd.read_csv(self.LANGUAGES_FILE, sep=';').query(f"language == '{language}'")
    #     return df[field].values[0]
    #
    # def get_column_from_reference(self, column) -> list:
    #     df = pd.read_csv(self.LANGUAGES_FILE,  sep=';')
    #     return df[column].values
    #
    # def write_value_to_TC_by_test_name(self, test_name: str, field_name: str, value, override=False) -> None:
    #     wb = load_workbook(self.TEST_CASES_FILE)
    #     sh = wb.active
    #     r, c = self.get_position_by_name_and_value(sh, "Test Cases", test_name)
    #     c = self.get_column_by_name(sh, field_name)
    #     sh.cell(r, c).value = value
    #     wb.save(self.TEST_CASES_FILE)
    #
    # def get_position_by_name_and_value(self, sh: Worksheet, field_name: str, field_value: str, contains_name=True) -> (int, int):
    #     r = 0
    #     c = self.get_column_by_name(sh, field_name, contains_name)
    #     for row in range(2, sh.max_row):
    #         cv = sh.cell(row,c).value
    #         if (contains_name and cv in field_value) or (not contains_name and cv == field_value):
    #                 r = row
    #                 break
    #     return r, c
    #
    # def get_column_by_name(self, sh: Worksheet, field_name, contains_name=True) -> int:
    #     c = 0
    #     for col in range(1, sh.max_column+1):
    #         cv = sh.cell(1,col).value
    #         if (contains_name and field_name in cv) or (not contains_name and cv == field_name):
    #                 c = col
    #                 break
    #     return c

# tp = KeywordsTypofix()
# print(tp.customize_url('https://www.cnn.com/aaaaa=bbbbb'))

# wb = load_workbook(os.path.join(tp.RESOURCES_DIR, "test_data", "TestCases.xlsx"))
# ws = wb.active
# print(tp.get_position_by_name_and_value(ws, "Test Cases","44. Guns N’ Roses [Czech (academic rules)]" ))
# print(tp.get_position_by_name_and_value(ws,"Test Cases", "66. Correct form of et al. [Czech (academic rules)]" ))
# # print(tp.write_value_to_TC_by_test_name("66. Correct form of et al. [Czech (academic rules)]", "fixes_count", 10))