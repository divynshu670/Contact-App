import '../entities/contact.dart';
import '../repositories/contact_repository_interface.dart';

class AddContact {
  final ContactRepository repository;
  AddContact(this.repository);

  Future<void> call(Contact contact) async {
    return await repository.addContact(contact);
  }
}
