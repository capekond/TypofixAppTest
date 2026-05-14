import argparse
import os
import re
import sys
from datetime import datetime
import pandas as pd
from openpyxl import load_workbook
from pathlib import Path

class Helpers:
    def __init__(self):
        self.RESOURCES_DIR =  os.path.join(Path(__file__).parent.parent, "tests", "resources", "test_data")
        self.PATTERN = "_pattern"
    def get_args(self):
        parser = argparse.ArgumentParser()
        store = os.path.join(self.RESOURCES_DIR, "DataStore.xlsx")
        tc = os.path.join(self.RESOURCES_DIR, "TestCases.xlsx")
        generic = parser.add_argument_group('Basic arguments')
        generic.add_argument("-n", "--no_question", action='store_true', help="Disable approval question")
        generic.add_argument("-i", "--input", default=store, help=f"Source Excel file. Implicit value {store}")
        generic.add_argument("-o", "--output", default=tc, help=f"Target Excel file. Implicit value {tc}")
        return parser.parse_args()

    def last_in(self, file):
        wb = load_workbook(file)
        last = wb.worksheets[len(wb.worksheets)-1]
        print(f"Selected source worksheet {last.title}")
        return last

    def first_out(self, file):
        wb = load_workbook(file)
        first = wb.copy_worksheet(wb[self.PATTERN])
        first.title = "tc_A"
        print(len(wb.worksheets))
        wb.move_sheet(first, offset=- (len(wb.worksheets)-1))
        print(f"Selected target worksheet {first.title}")
        return first
if __name__ == "__main__":
    m = Helpers()
    p = m.get_args()
    print(f"Content of last list from {p.input} will be formatted and transferred to {p.output} ")
    print("For more info let try --help")
    if p.no_question or input('Do you like to proceed the task? [Y/n]  ') == "Y":
        source = m.last_in(p.input)
        target = m.first_out(p.output)
        target.parent.save(p.output)
    else:
        print("Disapproved by user ")

