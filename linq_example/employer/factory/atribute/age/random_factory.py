from employer.factory.atribute.age.base_factory import AgeFactory
from employer.factory.atribute.range_attribute_factory import EmployerRandomRangeFactory, \
    EmployerRandomFromCollectionFactory


class AgeRandomRangeFactory(EmployerRandomRangeFactory, AgeFactory):
    def __init__(self, start=18, last=65):
        if start < 0 or last > 150:
            raise ValueError('Возраст должен быть в реальном диапазоне')
        super(AgeRandomRangeFactory, self).__init__(start, last)


class AgeRandomListFactory(EmployerRandomFromCollectionFactory, AgeFactory):
    def __init__(self, age_list: list[int]):
        super(AgeRandomListFactory, self).__init__(age_list)
