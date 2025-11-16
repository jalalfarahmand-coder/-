import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../data/models/contact_model.dart';
import '../bloc/phone_book_bloc.dart';
import '../../data/repositories/phone_book_repository.dart';
import 'add_edit_contact_screen.dart'; // We will create this screen next

class PhoneBookScreen extends StatelessWidget {
  const PhoneBookScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => PhoneBookBloc(PhoneBookRepository())..add(LoadContacts()),
      child: DefaultTabController(
        length: 2,
        child: Scaffold(
          appBar: AppBar(
            title: const Text('دفترچه تلفن'),
            actions: [
              IconButton(
                icon: const Icon(Icons.search),
                onPressed: () {
                  // Implement search functionality
                },
              ),
            ],
            bottom: const TabBar(
              tabs: [
                Tab(text: 'حقیقی'),
                Tab(text: 'حقوقی'),
              ],
            ),
          ),
          body: BlocBuilder<PhoneBookBloc, PhoneBookState>(
            builder: (context, state) {
              if (state is PhoneBookLoading) {
                return const Center(child: CircularProgressIndicator());
              }
              if (state is PhoneBookLoaded) {
                return TabBarView(
                  children: [
                    _buildContactList(context, state.contacts, ContactType.individual),
                    _buildContactList(context, state.contacts, ContactType.legal),
                  ],
                );
              }
              if (state is PhoneBookError) {
                return Center(child: Text('خطا: ${state.message}'));
              }
              return const Center(child: Text('برای شروع، مخاطبی اضافه کنید'));
            },
          ),
          floatingActionButton: FloatingActionButton(
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (_) => BlocProvider.value(
                    value: BlocProvider.of<PhoneBookBloc>(context),
                    child: const AddEditContactScreen(),
                  ),
                ),
              );
            },
            child: const Icon(Icons.add),
          ),
        ),
      ),
    );
  }

  Widget _buildContactList(BuildContext context, List<Contact> allContacts, ContactType type) {
    final filteredContacts = allContacts.where((c) => c.type == type).toList();

    if (filteredContacts.isEmpty) {
      return Center(child: Text('هیچ مخاطب ${type == ContactType.individual ? "حقیقی" : "حقوقی"} یافت نشد.'));
    }

    return ListView.builder(
      itemCount: filteredContacts.length,
      itemBuilder: (context, index) {
        final contact = filteredContacts[index];
        return ListTile(
          title: Text(contact.fullName),
          subtitle: Text(contact.type == ContactType.individual ? contact.nationalId ?? '' : contact.companyNationalId ?? ''),
          onTap: () {
            // Navigate to contact details screen
          },
        );
      },
    );
  }
}
