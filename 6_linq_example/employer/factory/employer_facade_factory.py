from employer.factory.atribute.office.post_factory import PostFactory
from employer.factory.atribute.office.salary_factory import SalaryFactory
from employer.factory.atribute.workplace.base_factory import WorkplaceFactory
from employer.factory.employer_factory import *
from employer.factory.person_factory import PersonFactory


class EmployerFacadeFactory(EmployerFactory):
    def __init__(
            self,
            person_factory: PersonFactory,
            workplace_factory: WorkplaceFactory,
            post_factory: PostFactory,
            salary_factory: SalaryFactory,
            delivery_size: int
    ):
        self._delivery_size = delivery_size
        self._salary_factory = salary_factory
        self._post_factory = post_factory
        self._workplace_factory = workplace_factory
        self._person_factory = person_factory

    @property
    def delivery_size(self):
        return self._delivery_size

    @delivery_size.setter
    def delivery_size(self, value: int):
        if value < 1:
            raise ValueError('Значение должно быть больше нуля')
        self._delivery_size = value

    def create(self) -> Employer:
        person = self._person_factory.create()
        return Employer.from_person(
            person=person,
            workplace=self._workplace_factory.create_with_city(person.address.city),
            post=self._post_factory.create(),
            salary=self._salary_factory.create()
        )

    def create_count(self, count: int):
        for _ in range(count):
            yield self.create()

    def create_all(self) -> list[Employer]:
        return list(self.create_count(self._delivery_size))
