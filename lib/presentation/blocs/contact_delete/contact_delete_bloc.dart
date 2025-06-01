import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../domain/usecases/delete_contact.dart';
import 'contact_delete_event.dart';
import 'contact_delete_state.dart';

class ContactDeleteBloc extends Bloc<ContactDeleteEvent, ContactDeleteState> {
  final DeleteContact deleteContactUseCase;

  ContactDeleteBloc({required this.deleteContactUseCase})
    : super(ContactDeleteInitial()) {
    on<DeleteContactRequested>(_onDeleteRequested);
  }

  Future<void> _onDeleteRequested(
    DeleteContactRequested event,
    Emitter<ContactDeleteState> emit,
  ) async {
    emit(ContactDeleteLoading());
    try {
      await deleteContactUseCase(event.contactId);
      emit(ContactDeleteSuccess());
    } catch (e) {
      emit(ContactDeleteError(e.toString()));
    }
  }
}
