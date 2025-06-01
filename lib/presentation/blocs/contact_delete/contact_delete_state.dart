import 'package:equatable/equatable.dart';

abstract class ContactDeleteState extends Equatable {
  const ContactDeleteState();
  @override
  List<Object?> get props => [];
}

class ContactDeleteInitial extends ContactDeleteState {}

class ContactDeleteLoading extends ContactDeleteState {}

class ContactDeleteSuccess extends ContactDeleteState {}

class ContactDeleteError extends ContactDeleteState {
  final String error;
  const ContactDeleteError(this.error);
  @override
  List<Object?> get props => [error];
}
