import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/entities/contact.dart';
import '../../domain/usecases/delete_contact.dart';
import '../blocs/contact_list/contact_list_bloc.dart';
import '../blocs/contact_list/contact_list_event.dart';
import '../blocs/contact_list/contact_list_state.dart';
import '../widgets/contact_list_item.dart';
import 'contact_form_page.dart';

class ContactListPage extends StatefulWidget {
  const ContactListPage({super.key});

  @override
  State<ContactListPage> createState() => _ContactListPageState();
}

class _ContactListPageState extends State<ContactListPage> {
  late TextEditingController _searchController;

  @override
  void initState() {
    super.initState();
    _searchController = TextEditingController();
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  void _onSearchChanged(String query) {
    context.read<ContactListBloc>().add(SearchContacts(query));
  }

  void _navigateToAddContact() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (_) => ContactFormPage()),
    ).then((_) {
      if (!mounted) return;
      context.read<ContactListBloc>().add(LoadContacts());
    });
  }

  void _navigateToEditContact(Contact contact) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => ContactFormPage(existingContact: contact),
      ),
    ).then((_) {
      if (!mounted) return;
      context.read<ContactListBloc>().add(LoadContacts());
    });
  }

  Future<void> _deleteContact(String id) async {
    final deleteUseCase = RepositoryProvider.of<DeleteContact>(context);
    await deleteUseCase(id);
    if (!mounted) return;
    context.read<ContactListBloc>().add(LoadContacts());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Contacts')),
      floatingActionButton: FloatingActionButton(
        onPressed: _navigateToAddContact,
        child: const Icon(Icons.add),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: _searchController,
              decoration: const InputDecoration(
                labelText: 'Search by name',
                prefixIcon: Icon(Icons.search),
              ),
              onChanged: _onSearchChanged,
            ),
          ),
          Expanded(
            child: BlocBuilder<ContactListBloc, ContactListState>(
              builder: (context, state) {
                if (state is ContactListLoading) {
                  return const Center(child: CircularProgressIndicator());
                } else if (state is ContactListLoaded) {
                  final contacts = state.contacts;
                  if (contacts.isEmpty) {
                    return const Center(child: Text('No contacts found.'));
                  }
                  return ListView.separated(
                    itemCount: contacts.length,
                    separatorBuilder: (_, __) => const Divider(height: 1),
                    itemBuilder: (context, index) {
                      final contact = contacts[index];
                      return GestureDetector(
                        onTap: () => _navigateToEditContact(contact),
                        onLongPress: () async {
                          final shouldDelete = await showDialog<bool>(
                            context: context,
                            builder:
                                (_) => AlertDialog(
                                  title: const Text('Delete Contact?'),
                                  content: Text(
                                    'Are you sure you want to delete ${contact.name}?',
                                  ),
                                  actions: [
                                    TextButton(
                                      onPressed:
                                          () =>
                                              Navigator.of(context).pop(false),
                                      child: const Text('Cancel'),
                                    ),
                                    TextButton(
                                      onPressed:
                                          () => Navigator.of(context).pop(true),
                                      child: const Text(
                                        'Delete',
                                        style: TextStyle(color: Colors.red),
                                      ),
                                    ),
                                  ],
                                ),
                          );
                          if (shouldDelete == true) {
                            await _deleteContact(contact.id);
                          }
                        },
                        child: ContactListItem(contact: contact),
                      );
                    },
                  );
                } else if (state is ContactListError) {
                  return Center(child: Text('Error: ${state.error}'));
                }
                return const SizedBox.shrink();
              },
            ),
          ),
        ],
      ),
    );
  }
}
