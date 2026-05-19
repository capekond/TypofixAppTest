import xml.etree.ElementTree as Et
from tests.resources.common import Common

class Helpers(Common):
    def __init__(self):
        super().__init__()

    def get_results(self, test_names):
        res = []
        to_report = Et.parse(m.REPORT_FILE).getroot()
        for test_name in test_names:
            rs = []
            s1 = f"./suite/suite/suite/suite/test[@name='{test_name}']"
            s2 = f"./suite/suite/suite/suite/test[@name='{test_name}']/kw/kw[@name='Element Text Should Be']/msg"
            status = to_report.find(s1)
            rs.append(status.find('status').attrib['status'])
            rs.append(status.find('status').attrib['start'])
            if rs[0] == 'FAIL':
                msg = to_report.findall(s2)
                info = msg[3].text.strip().replace('\n', '')
                rs.append(' '.join(info.split()).replace("'//*[@role=\"textbox\"]'", ''))
            else:
                rs.append('No error for PASS result')
            res.append(rs)
        return res


if __name__ == "__main__":
    m = Helpers()
    t_names = ['45__Correct_form_of_C__a_K__in_CzechCzech__academic_rules_',
               '44__Guns_N__RosesCzech__academic_rules_']
    s = m.get_results(t_names)
    print(s)