import os
from openpyxl import load_workbook
from pathlib import Path
from openpyxl.cell.cell import Cell
from openpyxl.worksheet.worksheet import Worksheet

class KeywordsTypofix(object):
    def __init__(self):
        self.RESOURCES_DIR = Path(__file__).parent.parent
        self.TEST_CASES_FILE = os.path.join(self.RESOURCES_DIR, "test_data", "TestCases.xlsx")
        self.TEST_CASES_WB = load_workbook(self.TEST_CASES_FILE)
        self.TEST_CASES_MISSING = self.TEST_CASES_WB["tc_no_examples"]
        self.MISSING_LL = 2
        self.LL = 2
        self.LANGUAGES_FILE = os.path.join(self.RESOURCES_DIR, 'test_data', 'references', '_list.csv')
        self.TEST_RESULTS_FIELDS = ("TEST_RESULT", "REAL", "DETAILS", "TIMESTAMP", "SCREENSHOT")
        self.HTML_TAGS = ['<br>', '<p>', '<span>']
        self.PATTERN = "_pattern"
        self.CLEAN_CHAR = '_'
        self.URL_DETAIL = 'https://typofix.slonline.sk/admin/rules/SLONline-Typofix-Model-Rule/EditForm/field/SLONline-Typofix-Model-Rule/item/'


    def build_before_after_for_languages(self,  data: list, languages: list[str], expected_languages: list[str]):
        even = []
        odd = []
        before = []
        after = []
        final_languages = []
        for i in range(0, len(data), 2):
            odd.append(data[i])
            even.append(data[i + 1])
        for i, language in enumerate(languages):
            if language in expected_languages:
                before.append(odd[i])
                after.append(even[i])
                final_languages.append(language)
        return final_languages, before, after

    def get_hyperlink_by_link_name(self, column_name: str, value) -> str:
        sh = self.TEST_CASES_WB.worksheets[0]
        r, c = self._get_position_by_name_and_value(sh, column_name, value)
        link = sh.cell(r, c).hyperlink
        return str(link.target)

    def create_new_excel_list_in_excel(self) -> str:
        first = self.TEST_CASES_WB.copy_worksheet(self.TEST_CASES_WB[self.PATTERN])
        self.TEST_CASES_WB.move_sheet(first, offset=- (len(self.TEST_CASES_WB.worksheets) - 1))
        first.title = "tc_A"
        for row in self.TEST_CASES_MISSING['A2:Z9000']:
            for cell in row:
                cell.value = None
        return first.title

    def add_missing_examples_to_excel(self, id: str, name: str, description: str, tag: str, languages: list[str]):
        for language in languages:
            self.TEST_CASES_MISSING.cell(row=self.MISSING_LL, column=1, value=self._clean_up_text(id + self.CLEAN_CHAR + name + self.CLEAN_CHAR + language.strip()))
            self.TEST_CASES_MISSING.cell(row=self.MISSING_LL, column=2, value=description)
            self.TEST_CASES_MISSING.cell(row=self.MISSING_LL, column=3, value=self._clean_up_text(tag))
            self.TEST_CASES_MISSING.cell(row=self.MISSING_LL, column=4, value=id)
            self._insert_excel_hyperlink(self.TEST_CASES_MISSING.cell(row=self.MISSING_LL, column=5), id + self.CLEAN_CHAR + name.strip(), id=id)
            self.TEST_CASES_MISSING.cell(row=self.MISSING_LL, column=6, value=language.strip())
            self.MISSING_LL += 1

    def add_new_test_cases_to_excel(self, excel_list: str, id: str, name: str, description: str, tag: str,languages: list[str], befores: list[str], afters: list[str]):
        ws = self.TEST_CASES_WB[excel_list]
        for i, language in enumerate(languages):
            ws.cell(row=self.LL, column=1, value=self._clean_up_text(id + self.CLEAN_CHAR + name + self.CLEAN_CHAR + language.strip()))
            ws.cell(row=self.LL, column=2, value=description)
            ws.cell(row=self.LL, column=3, value=self._clean_up_text(tag))
            ws.cell(row=self.LL, column=4, value=id)
            self._insert_excel_hyperlink(ws.cell(row=self.LL, column=5), id + " - " + name.strip(), id=id)
            ws.cell(row=self.LL, column=6, value=language.strip())
            ws.cell(row=self.LL, column=7, value=befores[i].strip())
            ws.cell(row=self.LL, column=8, value=afters[i].strip())
            self.LL += 1

    def add_results_to_excel(self, test_name, *f_values):
        errors = ""
        sh = self.TEST_CASES_WB.worksheets[0]
        row, x = self._get_position_by_name_and_value(sh, "Test Cases", test_name, False)
        if row == 0:
            errors = f"Test Case {test_name} not found"
        else:
            for i, field in enumerate(self.TEST_RESULTS_FIELDS):
                print(self.TEST_RESULTS_FIELDS[i], f_values[i])
                col = self._get_column_by_name(sh, field)
                sh.cell(row, col).value = f_values[i]
        return errors

    def save_test_case_excel(self) -> None:
        self.TEST_CASES_WB.save(self.TEST_CASES_FILE)

    def get_detail_link(self, id: str) -> str:
        return self.URL_DETAIL + id + "/edit?Root_LanguageExamples#Root_LanguageExamples"

    @staticmethod
    def typofix_split_string(s:str) -> list[str]:
        return [ss.strip() for ss in s.split(",")]

    def _get_position_by_name_and_value(self, sh: Worksheet, field_name: str, field_value: str, contains_name=True):
        r = 0
        c = self._get_column_by_name(sh, field_name, True)
        for row in range(2, sh.max_row):
            cv = sh.cell(row, c).value
            if (contains_name and cv in field_value) or (not contains_name and cv == field_value):
                r = row
                break
        return r, c

    @staticmethod
    def _get_column_by_name(sh: Worksheet, field_name, contains_name=True) -> int:
        c = 0
        for col in range(1, sh.max_column + 1):
            cv = sh.cell(1, col).value
            if (contains_name and field_name in cv) or (not contains_name and cv == field_name):
                c = col
                break
        return c

    def _insert_excel_hyperlink(self, c: Cell, name: str, id: str):
        c.value = name
        c.hyperlink = self.get_detail_link(id)

    def _clean_up_text(self, txt: str) -> str:
        res = ""
        for t in txt:
            res += self.CLEAN_CHAR if t.isspace() or not (t.isalnum()) else t
        return res


# l = ['Czech (academic rules)', 'Danish', 'Dutch', 'English (UK)', 'German (Germany)', 'Greek', 'Hungarian', 'Polish',
#      'Slovak', 'Slovenian', 'Spanish']
# d = [['nar. 12. 1. 2001'], ['nar. 12. 1. 2001'], ['(f. 1805, d. 1875)'], ['(f. 1805, d. 1875)'], ['Comenius [geb. 1592]'], ['Comenius [geb. 1592]'], ['b. 1974'], ['b. 1974'], ['geb. 1974, gest. 2000', 'Comenius [geb. 1592]'], ['geb. 1974, gest. 2000', 'Comenius [geb. 1592]'], ['γ. 1456 / γεν. 1456 / θ. 1512 / θαν. 1512'], ['γ. 1456 / γεν. 1456 / θ. 1512 / θαν. 1512'], ['Comenius – szül. 1592'], ['Comenius – szül. 1592'], ['ur. 1974', 'ur. 2 listopada 1974'], ['ur. 1974', 'ur. 2 listopada 1974'], ['nar. 12. 1. 2001'], ['nar. 12. 1. 2001'], ['roj. 1987, umr. 2000'], ['roj. 1987, umr. 2000'], ['Juan Pérez (n. 1980)'], ['Juan Pérez (n. 1980)']]
#
tp = KeywordsTypofix()
# b, a = tp.split_before_after(d, l, ["English (UK)", "German (Germany)", "Greek"])
#
# print(b)
# print(a)
tp.create_new_excel_list_in_excel()
# tp.add_missing_examples_to_excel("7","My example 1","My example description  1", "My example tag 1", ['Czech','Latin'])
# tp.add_missing_examples_to_excel("7","My example 2","My example description  2", "My example tag 2", ['Czech','Latin', 'UK'])
tp.save_test_case_excel()