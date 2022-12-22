from pathlib import Path

from employer.data_providers.employer.base_sender import *
from employer.data_providers.json_provider import JsonWriter
from employer.models.employer import Employer


class JsonEmployerTransformer(EmployerTransformer):
    def transform(self, employer: Employer) -> Any:
        return employer.to_map()


class EmployerJsonSender(EmployerSender):
    def __init__(self, path: Path, transformer: EmployerTransformer, encoding='utf-8'):
        super(EmployerJsonSender, self).__init__(transformer)
        self._writer = JsonWriter(path, encoding)

    @property
    def writer(self):
        return self._writer

    def send(self, employer: Employer):
        data = self._transformer.transform(employer)
        self._writer.write(data)

    def send_all(self, employers: list[Employer]):
        data = [self._transformer.transform(e) for e in employers]
        self._writer.write(data)
