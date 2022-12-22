from employer.factory.atribute.base_attribute_factory import *
from employer.factory.atribute.gender.base_factory import GenderFactory, Gender


class GenderRandomFactory(GenderFactory, EmployerAttributeRandomFactory):
    def __init__(self, male_frequency=47):
        """
        :param male_frequency: частота мужчин, в %
        """
        self._male_frequency = male_frequency

    def create(self):
        role_value = random.randint(0, 99)
        if role_value < self._male_frequency:
            return Gender.male
        return Gender.female
