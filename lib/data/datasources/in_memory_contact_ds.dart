import 'package:uuid/uuid.dart';
import '../models/contact_model.dart';

class InMemoryContactDataSource {
  final List<ContactModel> _contacts = [];
  final _uuid = const Uuid();

  InMemoryContactDataSource() {
    _contacts.addAll([
      ContactModel(
        id: _uuid.v4(),
        name: 'Alice Johnson',
        phone: '+1-555-123-4567',
        email: 'alice@example.com',
      ),
      ContactModel(
        id: _uuid.v4(),
        name: 'Bob Smith',
        phone: '+1-555-987-6543',
        email: 'bob@example.com',
      ),
      ContactModel(
        id: _uuid.v4(),
        name: 'Charlie Davis',
        phone: '+1-555-234-5678',
        email: 'charlie.davis@example.com',
      ),
      ContactModel(
        id: _uuid.v4(),
        name: 'Diana Evans',
        phone: '+1-555-345-6789',
        email: 'diana.evans@example.com',
      ),
      ContactModel(
        id: _uuid.v4(),
        name: 'Ethan Foster',
        phone: '+1-555-456-7890',
        email: 'ethan.foster@example.com',
      ),
      ContactModel(
        id: _uuid.v4(),
        name: 'Fiona Green',
        phone: '+1-555-567-8901',
        email: 'fiona.green@example.com',
      ),
      ContactModel(
        id: _uuid.v4(),
        name: 'George Harris',
        phone: '+1-555-678-9012',
        email: 'george.harris@example.com',
      ),
      ContactModel(
        id: _uuid.v4(),
        name: 'Hannah Ingram',
        phone: '+1-555-789-0123',
        email: 'hannah.ingram@example.com',
      ),
      ContactModel(
        id: _uuid.v4(),
        name: 'Ian Jacobs',
        phone: '+1-555-890-1234',
        email: 'ian.jacobs@example.com',
      ),
      ContactModel(
        id: _uuid.v4(),
        name: 'Julia Kim',
        phone: '+1-555-901-2345',
        email: 'julia.kim@example.com',
      ),
      ContactModel(
        id: _uuid.v4(),
        name: 'Kevin Lee',
        phone: '+1-555-012-3456',
        email: 'kevin.lee@example.com',
      ),
      ContactModel(
        id: _uuid.v4(),
        name: 'Laura Martin',
        phone: '+1-555-123-9876',
        email: 'laura.martin@example.com',
      ),
      ContactModel(
        id: _uuid.v4(),
        name: 'Michael Nelson',
        phone: '+1-555-234-0987',
        email: 'michael.nelson@example.com',
      ),
      ContactModel(
        id: _uuid.v4(),
        name: 'Natalie Owens',
        phone: '+1-555-345-1098',
        email: 'natalie.owens@example.com',
      ),
    ]);
  }

  Future<List<ContactModel>> getContacts() async {
    await Future.delayed(const Duration(milliseconds: 200));
    return List.from(_contacts);
  }

  Future<void> insertContact(ContactModel contact) async {
    _contacts.add(contact);
  }

  Future<void> updateContact(ContactModel updated) async {
    final index = _contacts.indexWhere((c) => c.id == updated.id);
    if (index != -1) {
      _contacts[index] = updated;
    }
  }

  Future<void> removeContact(String id) async {
    _contacts.removeWhere((c) => c.id == id);
  }
}
