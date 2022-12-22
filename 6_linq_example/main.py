import data_lib

from linq.linq_api import LinqAPI, GroupPair
from employer.models.employer import Employer


def print_divider():
    print()
    print('-' * 75)
    print()


def print_employers(employers, end='\n\n'):
    for employer in employers:
        print(employer, end=end)
    print_divider()


def find_median(iterable: list):
    iterable.sort()
    return iterable[len(iterable)//2]


def age_and_salary_comparer(first: Employer, last: Employer) -> bool:
    rich = first.salary > last.salary
    return rich and first.age < last.age or rich


def linq_example(employers: list[Employer]):
    print('Самый молодой и высокооплачиваемый сотрудник:\n')
    result = LinqAPI(employers) \
        .sort_by(age_and_salary_comparer) \
        .first()
    print(result)


def linq_example_2(employers: list[Employer]):
    print_divider()
    result = LinqAPI(employers) \
        .where(lambda e: e.age < 30 and e.salary > 60000) \
        .count()
    print(f'Количество сотрудников до 30 лет с зп от 60000 тыс.: {result}')
    print_divider()


def linq_example_3(employers: list[Employer]):
    print('Рейтинг фирм по медианному уровню оплаты труда по Ярославлю и Рыбинску:\n')
    result = LinqAPI(employers) \
        .where(lambda e: e.workplace.address.city in ('Ярославль', 'Рыбинск')) \
        .group_by(lambda e: e.workplace.name, lambda e: e.salary) \
        .map(lambda pair: GroupPair(pair.key, find_median(pair.value))) \
        .sort_by(lambda pair_first, pair_second: pair_first.value > pair_second.value) \
        .map(lambda pair: f'Фирма: {pair.key}, медианная зп: {pair.value}') \
        .to_list()
    print_employers(result, '\n')


def linq_example_4(employers: list[Employer]):
    print('Гендерная специфика медианного уровня оплаты труда:\n')
    result = LinqAPI(employers) \
        .group_by(lambda e: e.gender, lambda e: e.salary) \
        .map(lambda pair: GroupPair(pair.key, find_median(pair.value))) \
        .sort_by(lambda first, last: first.value > last.value) \
        .map(lambda pair: f'Пол: {pair.key.value}, медианная зп: {pair.value}') \
        .to_list()
    print_employers(result, '\n')


def linq_example_5(employers: list[Employer]):
    print('Медианный возраст сотрудников с доходами более 50000 рублей, по должностям:\n')
    result = LinqAPI(employers) \
        .where(lambda e: e.salary > 50000) \
        .group_by(lambda e: e.post, lambda e: e.age) \
        .map(lambda pair: GroupPair(pair.key, find_median(pair.value))) \
        .sort_by(lambda first, last: first.value < last.value) \
        .map(lambda pair: f'Должность: {pair.key.value}, возраст: {pair.value}') \
        .to_list()

    print_employers(result, '\n')


def main():
    employers = data_lib.get_employers()
    print(f'\nПример человека:\n\n{employers[0]}')
    print_divider()
    linq_example(employers)
    linq_example_2(employers)
    linq_example_3(employers)
    linq_example_4(employers)
    linq_example_5(employers)


if __name__ == '__main__':
    main()
