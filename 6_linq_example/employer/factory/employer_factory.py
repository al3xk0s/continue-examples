from employer.models.employer import Employer


class EmployerFactory:
    def create(self) -> Employer:
        raise NotImplementedError

    def create_all(self) -> list[Employer]:
        raise NotImplementedError
