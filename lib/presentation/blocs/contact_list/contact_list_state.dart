import 'package:equatable/equatable.dart';
import '../../../domain/entities/contact.dart';

abstract class ContactListState extends Equatable {
  const ContactListState();
  @override
  List<Object?> get props => [];
}

class ContactListInitial extends ContactListState {}

class ContactListLoading extends ContactListState {}

class ContactListLoaded extends ContactListState {
  final List<Contact> contacts;
  const ContactListLoaded(this.contacts);
  @override
  List<Object?> get props => [contacts];
}

class ContactListError extends ContactListState {
  final String error;
  const ContactListError(this.error);
  @override
  List<Object?> get props => [error];
}
