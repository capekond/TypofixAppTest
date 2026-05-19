import argparse
import os
from openpyxl import load_workbook
import xml.etree.ElementTree as ET

from webob.datetime_utils import year

from tests.resources.common import Common


class Helpers(Common):
    def __init__(self):
        super().__init__()


if __name__ == "__main__":
    m = Helpers()
    src = ET.parse(m.REPORT_FILE).getroot()
    print("---X-")
    root = ET.parse(m.REPORT_FILE).getroot()
    status = root.find("./suite/suite/suite/suite/test[@name='44__Guns_N__RosesCzech__academic_rules_']")
    print(status.find('status').attrib['status'])
    print(status.find('status').attrib['start'])
    print("---X-")
    root = ET.parse(m.REPORT_FILE).getroot()
    status = root.find("./suite/suite/suite/suite/test[@name='45__Correct_form_of_C__a_K__in_CzechCzech__academic_rules_']")
    print(status.find('status').attrib['status'])
    print(status.find('status').attrib['start'])
    print("dddddd")
    msg = root.find("./suite/suite/suite/suite/test[@id='s1-s1-s1-s1-t3']/kw/kw[@name='Element Text Should Be']/msg")
    print(msg.text)
    print("---X-")
    print(msg.attrib)
    for msg in root.findall("./suite/suite/suite/suite/test[@id='s1-s1-s1-s1-t3']/kw/kw[@name='Element Text Should Be']/msg"):
        print("---Xxxx-")
        print(msg.text)
    msg  = root.findall("./suite/suite/suite/suite/test[@id='s1-s1-s1-s1-t3']/kw/kw[@name='Element Text Should Be']/msg")
    print("---Xxxxaaa-")
    print(msg[3].text)