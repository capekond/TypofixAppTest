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
        self.RESOURCES_DIR =  os.path.join(Path(__file__).parent, "tests", "resources", "test_data")
    def get_args(self):
        parser = argparse.ArgumentParser()
        store = os.path.join(self.RESOURCES_DIR, "DataStore.xlsx")
        tc = os.path.join(self.RESOURCES_DIR, "TestCases.xlsx")
        generic = parser.add_argument_group('Basic arguments')
        generic.add_argument("-n", "--no_question", action='store_true', help="Disable approval question")
        generic.add_argument("-i", "--input", default=store, help=f"Source Excel file. Implicit value {store}")
        generic.add_argument("-o", "--output", default=tc, help=f"Target Excel file. Implicit value {tc}")
        return parser.parse_args()

if __name__ == "__main__":
    m = Helpers()
    p = m.get_args()
    print(f"Content of last list from {p.input} will be formatted and transferred to {p.output} ")
    print("For more info let try --help")
    if p.no_question or input('Do you like to proceed the task? [Y/n]  ') == "Y":
        print("Approved by user ")
    else:
        print("Disapproved by user ")

