import json
from pathlib import Path

from employer.data_providers.file_provider import FileWriter, FileReader


class JsonWriter(FileWriter):
    def __init__(self, path: Path, encoding='utf-8'):
        super(JsonWriter, self).__init__(path, encoding)

    def write(self, data):
        with open(self._path, 'w', encoding=self._encoding) as file:
            json.dump(data, file)


class JsonReader(FileReader):
    def __init__(self, path: Path, encoding='utf-8'):
        super(JsonReader, self).__init__(path, encoding)

    def read(self):
        with open(self._path, 'r', encoding=self._encoding) as file:
            data = json.load(file)
        return data
