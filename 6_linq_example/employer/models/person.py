from employer.models.name import Name
from employer.models.gender import Gender
from employer.models.address import Address
import employer.models.gender as gender_lib


class Person:
    def __init__(self, name: Name, address: Address, age: int,  gender: Gender) -> None:
        self.name = name
        self.address = address
        self.gender = gender
        self.age = age

    def to_map(self):
        return {
            'name': self.name.to_map(),
            'address': self.address.to_map(),
            'gender': self.gender.value,
            'age': self.age
        }

    @staticmethod
    def from_map(json_map):
        return Person(
            Name.from_map(json_map['name']),
            Address.from_map(json_map['address']),
            int(json_map['age']),
            gender_lib.reverse_map[json_map['gender']],
        )

    def __str__(self):
        return f'Имя: {self.name}\n' \
               f'Пол: {self.gender.value}\n' \
               f'Возраст: {self.age}\n' \
               f'Место жительства: {self.address}'
