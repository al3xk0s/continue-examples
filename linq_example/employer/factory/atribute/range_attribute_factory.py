from employer.factory.atribute.base_attribute_factory import *


class EmployerRandomFromCollectionFactory(EmployerAttributeRandomFactory):
    def __init__(self, collection):
        if len(collection) == 0:
            raise ValueError('Коллекция должна содержать хотя бы один элемент')

        self._collection = collection

    def create(self):
        return self._get_random_value(self._collection)


class EmployerRandomRangeFactory(EmployerAttributeRandomFactory):
    def __init__(self, start, last):
        self._start = start
        self._last = last

    def create(self):
        return random.randint(self._start, self._last)

