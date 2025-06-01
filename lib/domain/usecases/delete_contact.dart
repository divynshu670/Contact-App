import '../repositories/contact_repository_interface.dart';

class DeleteContact {
  final ContactRepository repository;
  DeleteContact(this.repository);

  Future<void> call(String contactId) async {
    return await repository.deleteContact(contactId);
  }
}
