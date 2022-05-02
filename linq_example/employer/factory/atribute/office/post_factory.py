from employer.factory.atribute.base_attribute_factory import EmployerAttributeRandomFactory
from employer.models.post import Post, values


class PostFactory:
    def create(self) -> Post:
        raise NotImplementedError


class PostRandomFactory(PostFactory, EmployerAttributeRandomFactory):
    def create(self):
        return self._get_random_value(values)
    