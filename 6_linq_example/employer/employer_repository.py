from employer.data_providers.employer.provider import EmployerProvider
from employer.models.employer import Employer


class EmployerRepository:
    def __init__(
            self,
            employer_provider: EmployerProvider,
            data: list[Employer] = None
    ):
        self._provider = employer_provider
        self._data: list[Employer] = data if data is not None else []

    @property
    def data(self):
        return self._data

    def load(self):
        self._data += self._provider.get_employers()
        return self._data

    def save(self):
        self._provider.send_all(self._data)
