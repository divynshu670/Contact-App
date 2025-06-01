class ContactFormState {
  final String? id;
  final String name;
  final String phone;
  final String email;
  final bool isNameValid;
  final bool isPhoneValid;
  final bool isEmailValid;
  final bool isSubmitting;
  final bool showErrorMessages;
  final String? submissionError;

  ContactFormState({
    required this.id,
    required this.name,
    required this.phone,
    required this.email,
    required this.isNameValid,
    required this.isPhoneValid,
    required this.isEmailValid,
    required this.isSubmitting,
    required this.showErrorMessages,
    required this.submissionError,
  });

  factory ContactFormState.initial() {
    return ContactFormState(
      id: null,
      name: '',
      phone: '',
      email: '',
      isNameValid: true,
      isPhoneValid: true,
      isEmailValid: true,
      isSubmitting: false,
      showErrorMessages: false,
      submissionError: null,
    );
  }

  ContactFormState copyWith({
    String? id,
    String? name,
    String? phone,
    String? email,
    bool? isNameValid,
    bool? isPhoneValid,
    bool? isEmailValid,
    bool? isSubmitting,
    bool? showErrorMessages,
    String? submissionError,
  }) {
    return ContactFormState(
      id: id ?? this.id,
      name: name ?? this.name,
      phone: phone ?? this.phone,
      email: email ?? this.email,
      isNameValid: isNameValid ?? this.isNameValid,
      isPhoneValid: isPhoneValid ?? this.isPhoneValid,
      isEmailValid: isEmailValid ?? this.isEmailValid,
      isSubmitting: isSubmitting ?? this.isSubmitting,
      showErrorMessages: showErrorMessages ?? this.showErrorMessages,
      submissionError: submissionError,
    );
  }
}
