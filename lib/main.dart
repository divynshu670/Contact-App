import 'package:flutter/material.dart';
import 'app.dart';
import 'data/datasources/in_memory_contact_ds.dart';

void main() {
  final inMemoryDataSource = InMemoryContactDataSource();
  runApp(ContactsApp(dataSource: inMemoryDataSource));
}
