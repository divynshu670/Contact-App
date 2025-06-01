import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'data/datasources/in_memory_contact_ds.dart';
import 'data/repositories/contact_repository.dart';
import 'domain/usecases/fetch_contact.dart';
import 'domain/usecases/add_contact.dart';
import 'domain/usecases/edit_contact.dart';
import 'domain/usecases/delete_contact.dart';
import 'presentation/blocs/contact_list/contact_list_bloc.dart';
import 'presentation/blocs/contact_list/contact_list_event.dart';
import 'presentation/pages/contact_list_page.dart';

class ContactsApp extends StatelessWidget {
  final InMemoryContactDataSource dataSource;

  const ContactsApp({super.key, required this.dataSource});

  @override
  Widget build(BuildContext context) {
    final repository = ContactRepositoryImpl(dataSource: dataSource);

    final fetchUC = FetchContacts(repository);
    final addUC = AddContact(repository);
    final editUC = EditContact(repository);
    final deleteUC = DeleteContact(repository);

    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider(create: (_) => repository),
        RepositoryProvider(create: (_) => fetchUC),
        RepositoryProvider(create: (_) => addUC),
        RepositoryProvider(create: (_) => editUC),
        RepositoryProvider(create: (_) => deleteUC),
      ],
      child: MultiBlocProvider(
        providers: [
          BlocProvider(
            create:
                (_) =>
                    ContactListBloc(repository: repository)
                      ..add(LoadContacts()),
          ),
        ],
        child: MaterialApp(
          title: 'Flutter Contacts',
          theme: ThemeData.light(),
          darkTheme: ThemeData.dark(),
          themeMode: ThemeMode.system,
          home: const ContactListPage(),
        ),
      ),
    );
  }
}
