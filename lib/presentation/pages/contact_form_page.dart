import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/entities/contact.dart';
import '../../domain/usecases/add_contact.dart';
import '../../domain/usecases/edit_contact.dart';
import '../blocs/contact_form/contact_form_bloc.dart';
import '../blocs/contact_form/contact_form_event.dart';
import '../blocs/contact_form/contact_form_state.dart';

class ContactFormPage extends StatefulWidget {
  final Contact? existingContact;
  const ContactFormPage({super.key, this.existingContact});

  @override
  State<ContactFormPage> createState() => _ContactFormPageState();
}

class _ContactFormPageState extends State<ContactFormPage> {
  late final ContactFormBloc _formBloc;
  late final TextEditingController _nameController;
  late final TextEditingController _phoneController;
  late final TextEditingController _emailController;

  @override
  void initState() {
    super.initState();
    _phoneController = TextEditingController(
      text: widget.existingContact?.phone ?? '',
    );
    _emailController = TextEditingController(
      text: widget.existingContact?.email ?? '',
    );

    final addUC = RepositoryProvider.of<AddContact>(context);
    final editUC = RepositoryProvider.of<EditContact>(context);
    _formBloc = ContactFormBloc(
      addContactUseCase: addUC,
      editContactUseCase: editUC,
    );

    _formBloc.add(InitializeForm(existing: widget.existingContact));
  }

  @override
  void dispose() {
    _formBloc.close();
    _nameController.dispose();
    _phoneController.dispose();
    _emailController.dispose();
    super.dispose();
  }

  Future<void> _onSubmit() async {
    _formBloc.add(SubmitForm());
  }

  @override
  Widget build(BuildContext context) {
    final isEdit = widget.existingContact != null;

    return Scaffold(
      appBar: AppBar(title: Text(isEdit ? 'Edit Contact' : 'Add Contact')),
      body: BlocListener<ContactFormBloc, ContactFormState>(
        bloc: _formBloc,
        listenWhen:
            (previous, current) =>
                previous.isSubmitting && !current.isSubmitting,
        listener: (context, state) {
          if (state.submissionError == null) {
            Navigator.of(context).pop();
          } else {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text('Error: ${state.submissionError}')),
            );
          }
        },
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: BlocBuilder<ContactFormBloc, ContactFormState>(
            bloc: _formBloc,
            builder: (context, state) {
              return Column(
                children: [
                  TextFormField(
                    controller: _nameController,
                    decoration: InputDecoration(
                      labelText: 'Name *',
                      errorText:
                          state.showErrorMessages && !state.isNameValid
                              ? 'Name cannot be empty'
                              : null,
                    ),
                    onChanged: (v) => _formBloc.add(NameChanged(v)),
                  ),
                  const SizedBox(height: 12),
                  TextFormField(
                    controller: _phoneController,
                    decoration: InputDecoration(
                      labelText: 'Phone *',
                      errorText:
                          state.showErrorMessages && !state.isPhoneValid
                              ? 'Invalid phone number'
                              : null,
                    ),
                    keyboardType: TextInputType.phone,
                    onChanged: (v) => _formBloc.add(PhoneChanged(v)),
                  ),
                  const SizedBox(height: 12),
                  TextFormField(
                    controller: _emailController,
                    decoration: InputDecoration(
                      labelText: 'Email (optional)',
                      errorText:
                          state.showErrorMessages && !state.isEmailValid
                              ? 'Invalid email address'
                              : null,
                    ),
                    keyboardType: TextInputType.emailAddress,
                    onChanged: (v) => _formBloc.add(EmailChanged(v)),
                  ),
                  const SizedBox(height: 24),
                  state.isSubmitting
                      ? const CircularProgressIndicator()
                      : ElevatedButton(
                        onPressed: _onSubmit,
                        child: Text(isEdit ? 'Save Changes' : 'Add Contact'),
                      ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}
