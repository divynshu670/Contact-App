import '../entities/contact.dart';
import '../repositories/contact_repository_interface.dart';

class FetchContacts {
  final ContactRepository repository;
  FetchContacts(this.repository);

  Future<List<Contact>> call() async {
    return await repository.fetchContacts();
  }
}
