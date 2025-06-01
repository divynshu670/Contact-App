import 'package:equatable/equatable.dart';

abstract class ContactDeleteEvent extends Equatable {
  const ContactDeleteEvent();
  @override
  List<Object?> get props => [];
}

class DeleteContactRequested extends ContactDeleteEvent {
  final String contactId;
  const DeleteContactRequested(this.contactId);
  @override
  List<Object?> get props => [contactId];
}
