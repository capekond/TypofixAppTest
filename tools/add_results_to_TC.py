import xml.etree.ElementTree as Et
import pandas as pd
from openpyxl import load_workbook
from tests.resources.common import Common

class Helpers(Common):
    def __init__(self):
        super().__init__()

    def get_test_names_from_tc(self) -> list[str]:
        df = pd.read_excel(self.TEST_CASES_FILE, sheet_name=0)
        return df['*** Test Cases ***'].tolist()

    def get_results(self, t_names: list[str]) -> list[list[str]]:
        res = []
        to_report = Et.parse(self.REPORT_FILE).getroot()
        for test_name in test_names:
            try:
                rs = []
                s1 = f"./suite/suite/suite/suite/test[@name='{test_name}']"
                s2 = f"./suite/suite/suite/suite/test[@name='{test_name}']/kw/kw[@name='Element Text Should Be']/msg"
                status = to_report.find(s1)
                rs.append(status.find('status').attrib['status'])
                if rs[0] == 'FAIL':
                    msg = to_report.findall(s2)
                    info = msg[3].text.strip().replace('\n', '')
                    rs.append(' '.join(info.split()).replace("'//*[@role=\"textbox\"]'", ''))
                else:
                    rs.append('')
                rs.append(status.find('status').attrib['start'])
                res.append(rs)
            except AttributeError as e:
                print(f"For test '{test_name}' missing data in {self.REPORT_FILE}")
                print(e)
                exit(1)
        return res

    def write_test_names_from_tc(self, t_results: list[list[str]]) -> None:
        wb = load_workbook(self.TEST_CASES_FILE)
        sh = wb.worksheets[0]
        for rid, r in enumerate(t_results):
            for cid, c in enumerate(r):
                sh.cell(2 + rid, 9 + cid, c)
        wb.save(self.TEST_CASES_FILE)
        wb.close()

if __name__ == "__main__":
    m = Helpers()
    test_names = m.get_test_names_from_tc()
    print(f"Selected {len(test_names)} test cases:")
    print(*test_names, sep='\n')
    test_results = m.get_results(test_names)
    m.write_test_names_from_tc(test_results)
