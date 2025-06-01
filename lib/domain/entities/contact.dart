import 'package:equatable/equatable.dart';

class Contact extends Equatable {
  final String id;
  final String name;
  final String phone;
  final String? email;

  const Contact({
    required this.id,
    required this.name,
    required this.phone,
    this.email,
  });

  Contact copyWith({String? name, String? phone, String? email}) {
    return Contact(
      id: id,
      name: name ?? this.name,
      phone: phone ?? this.phone,
      email: email ?? this.email,
    );
  }

  @override
  List<Object?> get props => [id, name, phone, email];
}
