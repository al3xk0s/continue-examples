from pathlib import Path


class FileProvider:
    def __init__(self, path: Path, encoding='utf-8'):
        self._path = path
        self._encoding = encoding

    @property
    def path(self):
        return self._path

    def with_path(self, path: Path):
        self._path = path
        return self


class FileWriter(FileProvider):
    def __init__(self, path: Path, encoding):
        super(FileWriter, self).__init__(path, encoding)

    def write(self, data):
        raise NotImplementedError


class FileReader(FileProvider):
    def __init__(self, path: Path, encoding):
        super(FileReader, self).__init__(path, encoding)

    def read(self):
        raise NotImplementedError
