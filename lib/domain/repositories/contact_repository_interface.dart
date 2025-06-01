import '../entities/contact.dart';

abstract class ContactRepository {
  Future<List<Contact>> fetchContacts();
  Future<void> addContact(Contact contact);
  Future<void> editContact(Contact contact);
  Future<void> deleteContact(String contactId);
}
