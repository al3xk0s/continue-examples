from employer.models.address import Address


class Workplace:
    def __init__(self, name: str, address: Address) -> None:
        self.name = name
        self.address = address

    def copy_with(self, name: str = None, address: Address = None):
        name = name if name is not None else self.name
        address = address if address is not None else self.address
        return Workplace(name, address)

    def to_map(self):
        return {
            'name': self.name,
            'address': self.address.to_map(),
        }

    @staticmethod
    def from_map(json_map):
        return Workplace(
            json_map['name'],
            Address.from_map(json_map['address']),
        )

    def __str__(self):
        return f'{self.name}, {self.address}'
