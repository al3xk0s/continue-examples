from employer.data_providers.employer.base_recipient import EmployerRecipient, EmployerParser
from employer.factory.employer_factory import EmployerFactory
from employer.models.employer import Employer


class PassEmployerParser(EmployerParser):
    def parse(self, data) -> Employer:
        return data


class EmployerFactoryRecipient(EmployerRecipient):
    def __init__(self, factory: EmployerFactory):
        super(EmployerFactoryRecipient, self).__init__(PassEmployerParser())
        self._factory = factory

    def get_employer(self) -> Employer:
        return self._factory.create()

    def get_employers(self) -> list[Employer]:
        return self._factory.create_all()
