from pathlib import Path

from employer.data_providers.employer.base_recipient import *
from employer.data_providers.json_provider import JsonReader
from employer.models.employer import Employer


class EmployerJsonParser(EmployerParser):
    def parse(self, data) -> Employer:
        return Employer.from_map(data)


class EmployerJsonRecipient(EmployerRecipient):
    def __init__(self, path: Path, parser: EmployerParser, encoding='utf-8'):
        super(EmployerJsonRecipient, self).__init__(parser)
        self._reader = JsonReader(path, encoding)
        self._map_data = None
        self._length = 0
        self._index = 0

    def reset_buffer(self):
        self._map_data = None
        self._length = 0
        self._index = 0

    def get_employer(self) -> Employer | None:
        self._try_init_data()
        if self._index > self._length - 1:
            return None
        employer = Employer.from_map(self._map_data[self._index])
        self._index += 1
        return employer

    def get_employers(self) -> list[Employer] | None:
        self._try_init_data()
        employers = list(map(Employer.from_map, self._map_data))
        return employers

    def _try_init_data(self):
        if self._map_data is None:
            self._map_data = self._reader.read()
            self._length = len(self._map_data)