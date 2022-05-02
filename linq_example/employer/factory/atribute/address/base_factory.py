from employer.models.address import Address
from employer.factory.atribute.base_attribute_factory import *


class AddressFactory:
    def create(self) -> Address:
        raise NotImplementedError
