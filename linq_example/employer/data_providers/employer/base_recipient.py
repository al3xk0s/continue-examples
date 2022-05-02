from employer.models.employer import Employer


class EmployerParser:
    def parse(self, data) -> Employer:
        raise NotImplementedError


class EmployerRecipient:
    def __init__(self, parser: EmployerParser):
        self._parser = parser

    def get_employer(self) -> Employer:
        raise NotImplementedError

    def get_employers(self) -> list[Employer]:
        raise NotImplementedError
