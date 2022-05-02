class Name:
    def __init__(self, first: str, second: str, last: str) -> None:
        self.first = first
        self.second = second
        self.last = last

    def to_map(self):
        return {
            'first': self.first,
            'second': self.second,
            'last': self.last,
        }

    @staticmethod
    def from_map(json_map):
        return Name(
            json_map['first'],
            json_map['second'],
            json_map['last']
        )

    def __str__(self):
        return f'{self.last} {self.first} {self.second}'