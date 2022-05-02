from employer.factory.atribute.name.base_factory import *


class MaleNameFactory(NameFactory):
    def create(self) -> Name:
        raise NotImplementedError


class FemaleNameFactory(NameFactory):
    def create(self) -> Name:
        raise NotImplementedError
