from employer.factory.atribute.base_attribute_factory import *
from employer.factory.atribute.range_attribute_factory import EmployerRandomRangeFactory, \
    EmployerRandomFromCollectionFactory


class SalaryFactory:
    def create(self) -> int:
        raise NotImplementedError


class SalaryRandomFactory(EmployerRandomFromCollectionFactory, SalaryFactory):
    def __init__(self, salary_list: list[int]):
        super(SalaryRandomFactory, self).__init__(salary_list)


class SalaryRandomRangeFactory(EmployerRandomRangeFactory, SalaryFactory):
    def __init__(self, start=17000, last=75000):
        super(SalaryRandomRangeFactory, self).__init__(start, last)
