import employer.models.helper as helper
from enum import Enum


class Post(Enum):
    architect = 'архитектор'
    marketing_specialist = 'маркетолог'
    accountant = 'бухгалтер'
    crisis_manager = 'кризисный менеджер'
    system_admin = 'системный администратор'
    developer = 'разработчик ПО'
    dev_ops_engineer = 'devOps инженер'
    business_analyst = 'бизнес - аналитик'
    tester = 'тестировщики'


values = (
    Post.architect,
    Post.marketing_specialist,
    Post.accountant,
    Post.crisis_manager,
    Post.system_admin,
    Post.developer,
    Post.dev_ops_engineer,
    Post.business_analyst,
    Post.tester
)

reverse_map = helper.get_reverse_enum_map(values)
