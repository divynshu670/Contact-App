import 'package:equatable/equatable.dart';

abstract class ContactListEvent extends Equatable {
  const ContactListEvent();
  @override
  List<Object?> get props => [];
}

class LoadContacts extends ContactListEvent {}

class SearchContacts extends ContactListEvent {
  final String query;
  const SearchContacts(this.query);
  @override
  List<Object?> get props => [query];
}
