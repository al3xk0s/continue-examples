from employer.factory.atribute.name.gender_base_factory import MaleNameFactory, FemaleNameFactory
from employer.factory.atribute.name.random_factory import NameRandomFactory


class MaleNameRandomFactory(NameRandomFactory, MaleNameFactory):
    def __init__(self, male_first_names, male_second_names, male_last_names):
        super(MaleNameRandomFactory, self).__init__(
            male_first_names,
            male_second_names,
            male_last_names
        )


class FemaleNameRandomFactory(NameRandomFactory, FemaleNameFactory):
    def __init__(self, female_first_names, female_second_names, female_last_names):
        super(FemaleNameRandomFactory, self).__init__(
            female_first_names,
            female_second_names,
            female_last_names
        )
