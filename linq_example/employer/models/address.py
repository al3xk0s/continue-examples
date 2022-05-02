class Address:
    def __init__(
            self,
            city: str,
            street: str,
            house_number: str,
    ) -> None:
        self.city = city
        self.street = street
        self.house_number = house_number

    def copy_with(self, city: str = None, street: str = None, house_number: str = None):
        city = city if city is not None else self.city
        street = street if street is not None else self.street
        house_number = house_number if house_number is not None else self.house_number

        return Address(city, street, house_number)

    def to_map(self):
        return {
            'city': self.city,
            'street': self.street,
            'house_number': self.house_number,
        }

    @staticmethod
    def from_map(json_map):
        return Address(
            json_map['city'],
            json_map['street'],
            json_map['house_number']
        )

    def __str__(self):
        return f'г. {self.city}, {self.street}, {self.house_number}'
