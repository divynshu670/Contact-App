import '../entities/contact.dart';
import '../repositories/contact_repository_interface.dart';

class EditContact {
  final ContactRepository repository;
  EditContact(this.repository);

  Future<void> call(Contact contact) async {
    return await repository.editContact(contact);
  }
}
