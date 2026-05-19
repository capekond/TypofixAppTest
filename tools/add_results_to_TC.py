import argparse
import os

from numpy.ma.core import info
from openpyxl import load_workbook
import xml.etree.ElementTree as ET

from webob.datetime_utils import year

from tests.resources.common import Common


class Helpers(Common):
    def __init__(self):
        super().__init__()

    def get_results(self, test_names):
        for test_name in test_names:
            pass


if __name__ == "__main__":
    m = Helpers()
    to_report = ET.parse(m.REPORT_FILE).getroot()

    test_name = '45__Correct_form_of_C__a_K__in_CzechCzech__academic_rules_'
    s1 = f"./suite/suite/suite/suite/test[@name='{test_name}']"
    s2 = f"./suite/suite/suite/suite/test[@name='{test_name}']/kw/kw[@name='Element Text Should Be']/msg"
    status = to_report.find(s1)
    print(status.find('status').attrib['status'])
    print(status.find('status').attrib['start'])
    msg  = to_report.findall(s2)
    info = msg[3].text.strip().replace('\n', '')
    info = ' '.join(info.split()).replace("'//*[@role=\"textbox\"]'", '')
    print(info)