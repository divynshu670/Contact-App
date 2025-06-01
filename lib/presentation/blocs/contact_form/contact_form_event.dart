import 'package:contact_app/domain/entities/contact.dart';
import 'package:equatable/equatable.dart';

abstract class ContactFormEvent extends Equatable {
  const ContactFormEvent();
  @override
  List<Object?> get props => [];
}

class InitializeForm extends ContactFormEvent {
  final Contact? existing;
  const InitializeForm({this.existing});
  @override
  List<Object?> get props => [existing];
}

class NameChanged extends ContactFormEvent {
  final String name;
  const NameChanged(this.name);
  @override
  List<Object?> get props => [name];
}

class PhoneChanged extends ContactFormEvent {
  final String phone;
  const PhoneChanged(this.phone);
  @override
  List<Object?> get props => [phone];
}

class EmailChanged extends ContactFormEvent {
  final String email;
  const EmailChanged(this.email);
  @override
  List<Object?> get props => [email];
}

class SubmitForm extends ContactFormEvent {}
