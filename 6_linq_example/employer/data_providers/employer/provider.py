from employer.data_providers.employer.base_recipient import EmployerRecipient, Employer
from employer.data_providers.employer.base_sender import EmployerSender


class EmployerProvider:
    def __init__(
            self,
            sender: EmployerSender,
            recipient: EmployerRecipient,
    ):
        self._sender = sender
        self._recipient = recipient

    def send(self, employer: Employer):
        self._sender.send(employer)

    def send_all(self, employers: list[Employer]):
        self._sender.send_all(employers)

    def get_employer(self):
        return self._recipient.get_employer()

    def get_employers(self):
        return self._recipient.get_employers()
