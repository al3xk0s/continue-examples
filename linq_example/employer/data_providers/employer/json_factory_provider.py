from pathlib import Path
from typing import Tuple

from employer.data_providers.json_provider import JsonReader
from employer.factory.atribute.address.random_factory import AddressRandomFactory
from employer.factory.atribute.age.random_factory import AgeRandomRangeFactory
from employer.factory.atribute.gender.random_factory import GenderRandomFactory
from employer.factory.atribute.name.gender_random_factory import MaleNameRandomFactory, \
    FemaleNameRandomFactory
from employer.factory.atribute.office.post_factory import PostRandomFactory
from employer.factory.atribute.office.salary_factory import SalaryRandomRangeFactory
from employer.factory.atribute.workplace.random_factory import WorkplaceRandomFactory
from employer.factory.employer_facade_factory import EmployerFacadeFactory
from employer.factory.person_factory import PersonFacadeFactory


class JsonFactoryProvider:
    def __init__(self, names_json_path: Path = None, address_json_path: Path = None, encoding='utf-8'):
        self._names_path = self._get_path_or_default(
            'employer', 'data', 'names.json', path=names_json_path)

        self._address_path = self._get_path_or_default(
            'employer', 'data', 'address.json', path=address_json_path)

        self._reader = JsonReader(self._names_path, encoding)

    @staticmethod
    def _get_path_or_default(*args: str, path):
        if path is None:
            return Path(*args)

    def get_json_data(self):
        names = self._reader.with_path(self._names_path).read()
        address = self._reader.with_path(self._address_path).read()
        return names, address

    def get_name_factories(self):
        names = self._reader.with_path(self._names_path).read()
        male_names, female_names = names['male'], names['female']

        male_factory = MaleNameRandomFactory(
            male_names['first_names'], male_names['second_names'], male_names['last_names']
        )

        female_factory = FemaleNameRandomFactory(
            female_names['first_names'], female_names['second_names'], female_names['last_names']
        )
        return male_factory, female_factory

    def get_address_and_workplace_factory(self):
        address = self._reader.with_path(self._address_path).read()
        city_list, streets, workplace_names = \
            address['city_list'], address['streets'], address['workplace_names']

        address_factory = AddressRandomFactory(city_list, streets)
        workplace_factory = WorkplaceRandomFactory(workplace_names, address_factory)
        return address_factory, workplace_factory

    def get_person_and_workplace_factories(
            self,
            male_frequency=47,
            age_range: Tuple[int, int] = (18, 75)
    ):
        male, female = self.get_name_factories()
        address, workplace = self.get_address_and_workplace_factory()
        return PersonFacadeFactory(
            male,
            female,
            GenderRandomFactory(male_frequency),
            AgeRandomRangeFactory(age_range[0], age_range[1]),
            address,
        ), workplace

    def get_facade_factory(
            self,
            male_frequency=47,
            age_range: Tuple[int, int] = (18, 75),
            salary_range: Tuple[int, int] = (18000, 75000),
            delivery_size=10,
    ):
        person, workplace = self.get_person_and_workplace_factories(male_frequency, age_range)

        employer_factory = EmployerFacadeFactory(
            person,
            workplace,
            PostRandomFactory(),
            SalaryRandomRangeFactory(salary_range[0], salary_range[1]),
            delivery_size
        )
        return employer_factory
