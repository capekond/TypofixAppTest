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
    # tests = src.getroot().findall("//test[@name='44__Guns_N__RosesCzech__academic_rules_'")
    # tests = src.getroot().findall("//test")
    # tests = src.findall("/robot/suite/suite/suite/suite/test[@name='44__Guns_N__RosesCzech__academic_rules_'")
    for test in src.iter('test'):
        print(test.attrib)
    print("*****")

    tree = ET.parse(m.REPORT_FILE2)
    root = tree.getroot()
    #
    # for movie in root.iter('movie'):
    #     print(movie.attrib)

    for movie in root.findall("./genre/decade/movie/[year='1992']"):
        print(movie.attrib)

    print("*****")
    aaa = root.find("./genre/decade/movie/[year='1992']")
    print(aaa.attrib)

    print("-----")
    b2tf = root.find("./genre/decade/movie[@title='Back 2 the Future']")
    print(b2tf.attrib)
    print(b2tf.find('format').attrib)
    print(b2tf.find('format').text)
    pass

