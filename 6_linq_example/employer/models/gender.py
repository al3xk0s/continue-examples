from enum import Enum
from employer.models import helper


class Gender(Enum):
    male = 'М'
    female = 'Ж'


values = (
    Gender.male,
    Gender.female
)

reverse_map = helper.get_reverse_enum_map(values)
