from typing import Any

from employer.models.employer import Employer


class EmployerTransformer:
    def transform(self, employer: Employer) -> Any:
        raise NotImplementedError


class EmployerSender:
    def __init__(self, transformer: EmployerTransformer):
        self._transformer = transformer

    def send(self, employer: Employer):
        raise NotImplementedError

    def send_all(self, data: list[Employer]):
        raise NotImplementedError
