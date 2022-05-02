
from pathlib import Path
from employer.data_providers.employer.base_recipient import EmployerRecipient

from employer.data_providers.employer.json_factory_provider import JsonFactoryProvider
from employer.data_providers.employer.provider import EmployerProvider
from employer.employer_repository import EmployerRepository
from employer.data_providers.employer.json_sender import EmployerJsonSender, JsonEmployerTransformer
from employer.data_providers.employer.factory_recipient import EmployerFactoryRecipient
from employer.data_providers.employer.json_recipient import EmployerJsonRecipient, EmployerJsonParser


def _get_factory_loader(delivery_size) -> EmployerRecipient:
    factory = JsonFactoryProvider().get_facade_factory(delivery_size=delivery_size)
    return EmployerFactoryRecipient(factory)


def _get_json_loader(path: Path) -> EmployerRecipient:
    return EmployerJsonRecipient(path, EmployerJsonParser())


def get_employers():
    path = Path('employer', 'data', 'employers.json')
    provider = EmployerProvider(
        EmployerJsonSender(path, JsonEmployerTransformer()),
        _get_json_loader(path)
    )
    repository = EmployerRepository(provider)
    data = repository.load()
    return data
