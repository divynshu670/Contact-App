import '../../domain/entities/contact.dart';
import '../../domain/repositories/contact_repository_interface.dart';
import '../datasources/in_memory_contact_ds.dart';
import '../models/contact_model.dart';

class ContactRepositoryImpl implements ContactRepository {
  final InMemoryContactDataSource dataSource;

  ContactRepositoryImpl({required this.dataSource});

  @override
  Future<void> addContact(Contact contact) async {
    final model = ContactModel.fromEntity(contact);
    await dataSource.insertContact(model);
  }

  @override
  Future<void> deleteContact(String contactId) async {
    await dataSource.removeContact(contactId);
  }

  @override
  Future<List<Contact>> fetchContacts() async {
    final models = await dataSource.getContacts();
    final entities =
        models.map((m) => m.toEntity()).toList()..sort(
          (a, b) => a.name.toLowerCase().compareTo(b.name.toLowerCase()),
        );
    return entities;
  }

  @override
  Future<void> editContact(Contact contact) async {
    final model = ContactModel.fromEntity(contact);
    await dataSource.updateContact(model);
  }
}
