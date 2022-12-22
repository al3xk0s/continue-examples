from employer.factory.atribute.address.base_factory import AddressFactory
from employer.models.address import Address
from employer.factory.atribute.base_attribute_factory import *


class AddressRandomFactory(EmployerAttributeRandomFactory, AddressFactory):
    def __init__(
            self,
            city_list,
            streets,
            house_numbers=None,
    ):
        self._city_list = city_list
        self._streets = streets
        self._house_numbers = self._get_house_numbers(house_numbers)

    def create(self) -> Address:
        city = self._get_random_value(self._city_list)
        street = self._get_random_value(self._streets)
        house_number = self._get_random_value(self._house_numbers)
        return Address(city, street, house_number)

    @staticmethod
    def _get_house_numbers(house_numbers):
        if house_numbers is not None:
            return house_numbers
        return [AddressRandomFactory._get_apart_number(i) for i in range(1, 100)]

    @staticmethod
    def _get_apart_number(number: int):
        letters = 'абвг'
        last_value = 3

        role_value = random.randint(0, 99)
        if role_value < 10:
            return f'{number}{letters[random.randint(0, last_value)]}'
        return f'{number}'
