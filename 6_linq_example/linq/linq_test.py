import unittest
from linq.linq_api import LinqAPI, GroupPair


class MyTestCase(unittest.TestCase):
    def test_where(self):
        data = range(100)
        actual = LinqAPI(data) \
            .where(lambda i: i % 2 == 0) \
            .to_list()
        expected = [i for i in range(100) if i % 2 == 0]
        self.assertEqual(expected, actual)

    def test_map(self):
        data = range(100)
        actual = LinqAPI(data) \
            .map(lambda i: f'{i}') \
            .to_list()
        expected = [f'{i}' for i in range(100)]
        self.assertEqual(expected, actual)

    def test_range_at_start_and_last(self):
        data = [1, 2, 3, 4, 5, 6]
        actual = LinqAPI(data) \
            .range(2, 2) \
            .to_list()
        expected = [3, 4]
        self.assertEqual(expected, actual)

    def test_range_at_start(self):
        data = [1, 2, 3, 4, 5, 6]
        actual = LinqAPI(data) \
            .range(start=2) \
            .to_list()
        expected = [3, 4, 5, 6]
        self.assertEqual(expected, actual)

    def test_range_at_length(self):
        data = [1, 2, 3, 4, 5, 6]
        actual = LinqAPI(data) \
            .range(length=2) \
            .to_list()
        expected = [1, 2]
        self.assertEqual(expected, actual)

    def test_range_overflow(self):
        data = [1, 2, 3, 4, 5, 6]
        actual = LinqAPI(data) \
            .range(length=10) \
            .to_list()
        expected = [1, 2, 3, 4, 5, 6]
        self.assertEqual(expected, actual)

    def test_range_zero_length(self):
        data = [1, 2, 3, 4, 5, 6]
        actual = LinqAPI(data) \
            .range(length=0) \
            .to_list()
        expected = []
        self.assertEqual(expected, actual)

    def test_range_negative_params(self):
        data = [1, 2, 3, 4, 5, 6]
        expected = ValueError
        with self.assertRaises(expected):
            LinqAPI(data).range(length=-1)

        with self.assertRaises(expected):
            LinqAPI(data).range(start=-1)

        with self.assertRaises(expected):
            LinqAPI(data).range(-1, -1)

    def test_range_at(self):
        data = [1, 2, 3, 4, 5, 6]
        actual = LinqAPI(data) \
            .range_at(lambda i: i % 2 == 0) \
            .to_list()
        expected = [1, 3, 5]
        self.assertEqual(expected, actual)

    def test_distinct(self):
        data = [1, 1, 1, 2, 2, 3, 4, 5]
        actual = LinqAPI(data) \
            .distinct() \
            .to_list()
        expected = [1, 2, 3, 4, 5]
        self.assertEqual(expected, actual)

    def test_distinct_with_equals(self):
        data = ['МИХАИЛ', 'михаил', 'Илларион', 'Виталий', 'виталий']
        actual = LinqAPI(data) \
            .distinct_with_equals(lambda e1, e2: e1.lower() == e2.lower()) \
            .to_list()
        expected = ['МИХАИЛ', 'Илларион', 'Виталий']
        self.assertEqual(expected, actual)

    def test_reverse(self):
        data = [9, 7, 4, 13, 94, 3, 14, 5, 0, 1, -84]
        actual = LinqAPI(data) \
            .reverse() \
            .to_list()
        expected = data[::-1]
        self.assertEqual(expected, actual)

    def test_sort(self):
        data = [9, 7, 4, 13, 94, 3, 14, 5, 0, 1, -84]
        actual = LinqAPI(data) \
            .sort() \
            .to_list()
        expected = [-84, 0, 1, 3, 4, 5, 7, 9, 13, 14, 94]
        self.assertEqual(expected, actual)

    def test_sort_by(self):
        data = ['Дамир', 'Владимир', 'Владислав', 'Аркадий']
        actual = LinqAPI(data) \
            .sort_by(lambda a, b: len(a) > len(b)) \
            .to_list()
        expected = ['Владислав', 'Владимир', 'Аркадий', 'Дамир']
        self.assertEqual(expected, actual)

    def test_group_by(self):
        data = ['Дамир', 'Владимир', 'Владимир', 'Владислав', 'Аркадий', 'Аркадий']
        actual = LinqAPI(data) \
            .group_by(lambda s: s, lambda s: 1) \
            .to_list()
        expected = [
            GroupPair('Дамир', [1]),
            GroupPair('Владимир', [1, 1]),
            GroupPair('Владислав', [1]),
            GroupPair('Аркадий', [1, 1])]
        self.assertEqual(expected, actual)

    def test_concat(self):
        data = [1, 2, 3, 4, 5]
        actual = LinqAPI(data) \
            .concat(range(7, 17)) \
            .to_list()
        expected = [1, 2, 3, 4, 5] + list(range(7, 17))
        self.assertEqual(expected, actual)

    def test_first(self):
        data = [1, 2, 3, 4, 5, 6]
        actual = LinqAPI(data) \
            .first()
        expected = 1
        self.assertEqual(expected, actual)

    def test_last(self):
        data = [1, 2, 3, 4, 5, 6]
        actual = LinqAPI(data) \
            .last()
        expected = 6
        self.assertEqual(expected, actual)

    def test_count(self):
        data = [1, 2, 3, 4, 5, 19, 4, 3]
        actual = LinqAPI(data) \
            .count()
        expected = len(data)
        self.assertEqual(expected, actual)

    def test_number_integration(self):
        data = range(1, 100)
        actual = LinqAPI(data) \
            .where(lambda item: item % 3 == 0) \
            .range(length=10) \
            .reverse() \
            .to_list()
        expected = [3, 6, 9, 12, 15, 18, 21, 24, 27, 30][::-1]
        self.assertEqual(expected, actual)

    @staticmethod
    def _get_names():
        return [
            'Иван',         'Михаил',       'Виталий',      'Степан',
            'Артем',        'Владимир',     'Иван',         'Михаил',
            'Александр',    'Степан',       'Аркадий',      'Виталий',
            'Алексей',      'Юрий',         'Игорь',        'Андрей',
            'Екатерина',    'Александра',   'Евгения',      'Милана',
            'Жанна',        'Карина',       'Елизавета',    'Мария'
        ]

    def test_string_integration_case_one(self):
        data = self._get_names()
        actual = LinqAPI(data) \
            .where(lambda name: name[0] == 'А') \
            .distinct() \
            .sort() \
            .to_list()
        expected = ['Александр', 'Алексей', 'Артем', 'Аркадий', 'Андрей', 'Александра']
        expected.sort()
        self.assertEqual(expected, actual)

    class Person:
        def __init__(self, name):
            self.name = name

        def __eq__(self, other):
            return self.name == other.name

    def test_string_integration_case_two(self):
        data = self._get_names()

        actual = LinqAPI(data) \
            .where(lambda name: 'а' not in name.lower()) \
            .sort_by(lambda a, b: len(a) > len(b)) \
            .map(self.Person) \
            .to_list()
        expected = list(map(self.Person, ('Евгения', 'Игорь', 'Юрий')))
        self.assertEqual(expected, actual)


if __name__ == '__main__':
    unittest.main()
