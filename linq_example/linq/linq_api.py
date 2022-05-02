from typing import Callable, Iterable, Generic, TypeVar, Any

Item = TypeVar('Item')


class GroupPair:
    def __init__(self, key, value):
        self.key = key
        self.value = value

    def __str__(self):
        return f'{self.key}: {self.value}'

    def __eq__(self, other):
        return self.key == other.key and self.value == other.value


class LinqAPI(Generic[Item]):
    def __init__(self, collection: Iterable[Item]) -> None:
        self._collection = collection

    @property
    def data(self):
        return self._collection

    def where(self, predicate: Callable[[Item], bool]):
        generator = (i for i in self._collection if predicate(i))
        return LinqAPI(generator)

    def map(self, mapper: Callable[[Item], Any]):
        generator = (mapper(i) for i in self._collection)
        return LinqAPI(generator)

    def range(self, start=0, length=None):
        if start < 0 or (length is not None and length < 0):
            raise ValueError('Параметры метода были отрицательными')

        def get_generator():
            i = 0
            delivered_items_count = 0
            for item in self._collection:
                if length is not None and delivered_items_count >= length:
                    return
                if i < start:
                    i += 1
                    continue
                yield item
                delivered_items_count += 1
                i += 1
        return LinqAPI(get_generator())

    def range_at(self, index_predicate):
        def get_generator():
            i = 0
            for item in self._collection:
                if index_predicate(i):
                    yield item
                i += 1
        return LinqAPI(get_generator())

    def distinct(self):
        return LinqAPI(self._get_distinct_generator(lambda i, v: i not in v))

    def distinct_with_equals(self, equals: Callable[[Item, Item], bool]):
        def is_unique(item, values):
            for value in values:
                if equals(item, value):
                    return False
            return True

        return LinqAPI(self._get_distinct_generator(is_unique))

    def _get_distinct_generator(self, is_unique: Callable[[Item, list[Item]], bool]):
        _values = []
        for item in self._collection:
            if is_unique(item, _values):
                _values.append(item)
                yield item

    def reverse(self):
        iterable_list = self.to_list()[::-1]
        generator = (i for i in iterable_list)
        return LinqAPI(generator)

    def sort(self, reverse=False):
        comparator = lambda c, n: c < n

        if reverse:
            comparator = lambda c, n: c > n

        return self.sort_by(comparator)

    def sort_by(self, comparator: Callable[[Item, Item], bool]):
        def get_generator(current_is_before):
            buffer = [i for i in self._collection]
            length = len(buffer)

            for _ in range(length):
                current = buffer[0]
                for new_value in buffer:
                    if not current_is_before(current, new_value):
                        current = new_value
                buffer.remove(current)
                yield current

        return LinqAPI(get_generator(comparator))

    def group_by(
            self,
            key_selector: Callable[[Item], Any],
            result_selector: Callable[[Item], Any],
    ):
        def get_generator():
            result = dict()
            for i in self._collection:
                key = key_selector(i)
                if key not in result:
                    result[key] = []
                result[key].append(result_selector(i))
            return (GroupPair(k, v) for k, v in result.items())
        return LinqAPI(get_generator())

    def concat(self, other: Iterable[Item]):
        def get_generator():
            for item in self._collection:
                yield item

            for item in other:
                yield item

        return LinqAPI(get_generator())

    def first(self, default=None):
        for item in self._collection:
            return item
        return default

    def last(self, default=None):
        result = self.to_list()
        length = len(result)
        return result[length - 1] if length > 0 else default

    def count(self):
        return len(self.to_list())

    def to_list(self):
        result = [item for item in self._collection]
        return result

    def copy(self):
        return LinqAPI(self._collection)
