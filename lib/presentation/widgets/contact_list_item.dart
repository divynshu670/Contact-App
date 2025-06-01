import 'package:flutter/material.dart';
import '../../domain/entities/contact.dart';

class ContactListItem extends StatelessWidget {
  final Contact contact;
  const ContactListItem({super.key, required this.contact});

  @override
  Widget build(BuildContext context) {
    final initials =
        contact.name.isNotEmpty
            ? contact.name.trim().split(' ').map((w) => w[0]).take(2).join()
            : '';
    return ListTile(
      leading: CircleAvatar(
        backgroundColor: Theme.of(context).primaryColor,
        child: Text(initials, style: const TextStyle(color: Colors.white)),
      ),
      title: Text(contact.name),
      subtitle: Text(contact.phone),
      trailing: Icon(Icons.chevron_right),
    );
  }
}
