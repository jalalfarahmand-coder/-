import 'package:isar/isar.dart';
import '../models/contact_model.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:io';

class PhoneBookRepository {
  late Future<Isar> _db;

  PhoneBookRepository() {
    _db = _initDb();
  }

  Future<Isar> _initDb() async {
    if (Isar.instanceNames.isEmpty) {
      final dir = await getApplicationDocumentsDirectory();
      return await Isar.open(
        [ContactSchema], // Add other schemas here as we create them
        directory: dir.path,
        name: 'CarDealershipDb',
      );
    }
    return Future.value(Isar.getInstance('CarDealershipDb'));
  }

  // Get all contacts
  Future<List<Contact>> getAllContacts() async {
    final isar = await _db;
    return await isar.contacts.where().findAll();
  }

  // Get contacts by type
  Future<List<Contact>> getContactsByType(ContactType type) async {
    final isar = await _db;
    return await isar.contacts.filter().typeEqualTo(type).findAll();
  }

  // Add or Update a contact
  Future<void> saveContact(Contact contact) async {
    final isar = await _db;
    await isar.writeTxn(() async {
      await isar.contacts.put(contact);
    });
  }

  // Delete a contact
  Future<void> deleteContact(int contactId) async {
    final isar = await _db;
    await isar.writeTxn(() async {
      await isar.contacts.delete(contactId);
    });
  }

  // Search contacts
  Future<List<Contact>> searchContacts(String query) async {
    final isar = await _db;
    if (query.isEmpty) {
      return getAllContacts();
    }
    return await isar.contacts
        .filter()
        .fullNameContains(query, caseSensitive: false)
        .or()
        .nationalIdContains(query)
        .or()
        .companyNameContains(query, caseSensitive: false)
        .findAll();
  }
}
