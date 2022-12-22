from employer.models.workplace import Workplace


class WorkplaceFactory:
    def create(self) -> Workplace:
        raise NotImplementedError

    def create_with_city(self, city):
        workplace = self.create()
        return workplace.copy_with(address=workplace.address.copy_with(city=city))
