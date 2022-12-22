import random


class EmployerAttributeRandomFactory:
    @staticmethod
    def _get_random_value(my_list: list):
        length = len(my_list)
        return my_list[random.randint(0, length - 1)]
