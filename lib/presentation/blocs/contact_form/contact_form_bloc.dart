import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../domain/entities/contact.dart';
import '../../../domain/usecases/add_contact.dart';
import '../../../domain/usecases/edit_contact.dart';
import 'contact_form_event.dart';
import 'contact_form_state.dart';
import 'package:uuid/uuid.dart';

class ContactFormBloc extends Bloc<ContactFormEvent, ContactFormState> {
  final AddContact addContactUseCase;
  final EditContact editContactUseCase;
  final _uuid = const Uuid();

  ContactFormBloc({
    required this.addContactUseCase,
    required this.editContactUseCase,
  }) : super(ContactFormState.initial()) {
    on<InitializeForm>(_onInitializeForm);
    on<NameChanged>(_onNameChanged);
    on<PhoneChanged>(_onPhoneChanged);
    on<EmailChanged>(_onEmailChanged);
    on<SubmitForm>(_onSubmitForm);
  }

  void _onInitializeForm(InitializeForm event, Emitter<ContactFormState> emit) {
    if (event.existing != null) {
      final existing = event.existing!;
      emit(
        ContactFormState(
          id: existing.id,
          name: existing.name,
          phone: existing.phone,
          email: existing.email ?? '',
          isNameValid: true,
          isPhoneValid: true,
          isEmailValid: true,
          isSubmitting: false,
          showErrorMessages: false,
          submissionError: null,
        ),
      );
    } else {
      emit(ContactFormState.initial());
    }
  }

  void _onNameChanged(NameChanged event, Emitter<ContactFormState> emit) {
    final isValid = event.name.trim().isNotEmpty;
    emit(
      state.copyWith(
        name: event.name,
        isNameValid: isValid,
        showErrorMessages: false,
      ),
    );
  }

  void _onPhoneChanged(PhoneChanged event, Emitter<ContactFormState> emit) {
    // Now require exactly 10 digits (no spaces, no plus sign).
    final phonePattern = RegExp(r'^[0-9]{10}$');
    final isValid = phonePattern.hasMatch(event.phone.trim());
    emit(
      state.copyWith(
        phone: event.phone,
        isPhoneValid: isValid,
        showErrorMessages: false,
      ),
    );
  }

  void _onEmailChanged(EmailChanged event, Emitter<ContactFormState> emit) {
    final emailPattern = RegExp(r'^[\w\-\.]+@([\w\-]+\.)+[\w\-]{2,4}$');
    final isValid =
        event.email.trim().isEmpty || emailPattern.hasMatch(event.email.trim());
    emit(
      state.copyWith(
        email: event.email,
        isEmailValid: isValid,
        showErrorMessages: false,
      ),
    );
  }

  Future<void> _onSubmitForm(
    SubmitForm event,
    Emitter<ContactFormState> emit,
  ) async {
    final isNameValid = state.name.trim().isNotEmpty;
    // Enforce exactly 10 digits here as well
    final phonePattern = RegExp(r'^[0-9]{10}$');
    final isPhoneValid = phonePattern.hasMatch(state.phone.trim());
    final emailPattern = RegExp(r'^[\w\-\.]+@([\w\-]+\.)+[\w\-]{2,4}$');
    final isEmailValid =
        state.email.trim().isEmpty || emailPattern.hasMatch(state.email.trim());

    if (!isNameValid || !isPhoneValid || !isEmailValid) {
      emit(
        state.copyWith(
          isNameValid: isNameValid,
          isPhoneValid: isPhoneValid,
          isEmailValid: isEmailValid,
          showErrorMessages: true,
        ),
      );
      return;
    }

    emit(state.copyWith(isSubmitting: true, showErrorMessages: false));

    try {
      if (state.id == null) {
        final newContact = Contact(
          id: _uuid.v4(),
          name: state.name.trim(),
          phone: state.phone.trim(),
          email: state.email.trim().isEmpty ? null : state.email.trim(),
        );
        await addContactUseCase(newContact);
      } else {
        final updated = Contact(
          id: state.id!,
          name: state.name.trim(),
          phone: state.phone.trim(),
          email: state.email.trim().isEmpty ? null : state.email.trim(),
        );
        await editContactUseCase(updated);
      }

      emit(state.copyWith(isSubmitting: false));
    } catch (e) {
      emit(
        state.copyWith(
          isSubmitting: false,
          submissionError: e.toString(),
          showErrorMessages: true,
        ),
      );
    }
  }
}
