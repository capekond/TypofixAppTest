import json
import os

class KeywordsTypofix(object):

    def get_json_reference_file(self, file_name: str) -> dict:
        cwd = os.getcwd()
        json_file_path = os.path.join(cwd,  'tests', 'resources', 'test_data', 'references' , file_name + ".json")
        return json.load(open(json_file_path))



