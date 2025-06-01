import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../domain/entities/contact.dart';
import '../../../domain/repositories/contact_repository_interface.dart';
import 'contact_list_event.dart';
import 'contact_list_state.dart';

class ContactListBloc extends Bloc<ContactListEvent, ContactListState> {
  final ContactRepository repository;
  List<Contact> _allContacts = [];

  ContactListBloc({required this.repository}) : super(ContactListInitial()) {
    on<LoadContacts>(_onLoadContacts);
    on<SearchContacts>(_onSearchContacts);
  }

  Future<void> _onLoadContacts(
    LoadContacts event,
    Emitter<ContactListState> emit,
  ) async {
    emit(ContactListLoading());
    try {
      _allContacts = await repository.fetchContacts();
      emit(ContactListLoaded(List.from(_allContacts)));
    } catch (e) {
      emit(ContactListError(e.toString()));
    }
  }

  Future<void> _onSearchContacts(
    SearchContacts event,
    Emitter<ContactListState> emit,
  ) async {
    final query = event.query.trim().toLowerCase();
    final filtered =
        _allContacts.where((c) {
            return c.name.toLowerCase().contains(query);
          }).toList()
          ..sort(
            (a, b) => a.name.toLowerCase().compareTo(b.name.toLowerCase()),
          );
    emit(ContactListLoaded(filtered));
  }
}
