from employer.factory.atribute.address.base_factory import AddressFactory
from employer.factory.atribute.age.base_factory import AgeFactory
from employer.factory.atribute.gender.base_factory import GenderFactory
from employer.factory.atribute.name.gender_base_factory import MaleNameFactory, FemaleNameFactory
from employer.models.gender import Gender
from employer.models.person import Person


class PersonFactory:
    def create(self) -> Person:
        raise NotImplementedError


class PersonFacadeFactory(PersonFactory):
    def __init__(
            self,
            male_name_factory: MaleNameFactory,
            female_name_factory: FemaleNameFactory,
            gender_factory: GenderFactory,
            age_factory: AgeFactory,
            address_factory: AddressFactory
    ):
        self._age_factory = age_factory
        self._male_name_factory = male_name_factory
        self._female_name_factory = female_name_factory
        self._gender_factory = gender_factory
        self._address_factory = address_factory

    def create(self) -> Person:
        gender = self._gender_factory.create()

        if gender == Gender.male:
            name = self._male_name_factory.create()
        else:
            name = self._female_name_factory.create()

        age = self._age_factory.create()

        address = self._address_factory.create()
        return Person(
            name,
            address,
            age,
            gender
        )
