import os
from pathlib import Path



class WriteToFile(object):
    def __init__(self):
        self.RESOURCES_DIR = Path(__file__).parent.parent
        self.FILE_LOG = os.path.join(self.RESOURCES_DIR, 'log.txt')

    def typofix_file_log(self, line = "", is_new=False):
        if is_new:
            open(self.FILE_LOG, 'w').close()
        if line != "":
            with open(self.FILE_LOG, 'a') as file:
                file.write(line + "\n")


wtf = WriteToFile()
wtf.typofix_file_log(is_new=True)
wtf.typofix_file_log(line="Line 1")

wtf.typofix_file_log(line="Line 3")