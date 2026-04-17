import json


class KeywordsTypofix(object):

    def get_json_file(self, file_name: str) -> dict:
        return json.load(open(file_name))
