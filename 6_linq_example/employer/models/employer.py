from employer.models.person import *
from employer.models.post import Post
from employer.models.workplace import Workplace
import employer.models.post as post_lib


class Employer(Person):
    def __init__(
            self,
            name: Name,
            address: Address,
            age: int,
            gender: Gender,
            workplace: Workplace,
            post: Post,
            salary: int
    ) -> None:
        super(Employer, self).__init__(name, address, age, gender)
        self.salary = salary
        self.post = post
        self.workplace = workplace

    def to_map(self):
        return {
            'name': self.name.to_map(),
            'address': self.address.to_map(),
            'age': self.age,
            'gender': self.gender.value,
            'workplace': self.workplace.to_map(),
            'post': self.post.value,
            'salary': self.salary,
        }

    @staticmethod
    def from_map(json_map):
        return Employer(
            Name.from_map(json_map['name']),
            Address.from_map(json_map['address']),
            int(json_map['age']),
            gender_lib.reverse_map[json_map['gender']],
            Workplace.from_map(json_map['workplace']),
            post_lib.reverse_map[json_map['post']],
            int(json_map['salary'])
        )

    @staticmethod
    def from_person(person: Person, workplace: Workplace, post: Post, salary: int):
        return Employer(
            person.name,
            person.address,
            person.age,
            person.gender,
            workplace,
            post,
            salary
        )

    def __str__(self):
        return super().__str__() \
               + f'\nМесто работы: {self.workplace}\n' \
               f'Должность: {self.post.value}\n' \
               f'Заработная плата: {self.salary}'
