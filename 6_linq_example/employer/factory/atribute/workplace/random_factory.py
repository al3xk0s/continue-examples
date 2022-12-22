from employer.factory.atribute.address.base_factory import AddressFactory
from employer.factory.atribute.base_attribute_factory import *
from employer.factory.atribute.workplace.base_factory import WorkplaceFactory
from employer.models.workplace import Workplace


class WorkplaceRandomFactory(WorkplaceFactory, EmployerAttributeRandomFactory):
    def __init__(self, workplace_names, address_factory: AddressFactory):
        self._workplace_names = workplace_names
        self._address_factory = address_factory

    def create(self):
        name = self._get_random_value(self._workplace_names)
        address = self._address_factory.create()
        return Workplace(name, address)
