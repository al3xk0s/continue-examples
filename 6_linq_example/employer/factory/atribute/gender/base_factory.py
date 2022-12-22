from employer.models.gender import Gender


class GenderFactory:
    def create(self) -> Gender:
        raise NotImplementedError
