from employer.factory.atribute.base_attribute_factory import EmployerAttributeRandomFactory
from employer.factory.atribute.name.base_factory import NameFactory, Name


class NameRandomFactory(NameFactory, EmployerAttributeRandomFactory):
    def __init__(self, first_names, second_names, last_names):
        self._first_names = first_names
        self._second_names = second_names
        self._last_names = last_names

    def create(self):
        first = self._get_random_value(self._first_names)
        second = self._get_random_value(self._second_names)
        last = self._get_random_value(self._last_names)
        return Name(first, second, last)
