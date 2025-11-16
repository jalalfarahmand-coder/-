part of 'phone_book_bloc.dart';

abstract class PhoneBookEvent extends Equatable {
  const PhoneBookEvent();

  @override
  List<Object> get props => [];
}

// Event to load all contacts from the database
class LoadContacts extends PhoneBookEvent {}

// Event to filter contacts by type (Individual or Legal)
class FilterContacts extends PhoneBookEvent {
  final ContactType type;

  const FilterContacts(this.type);

  @override
  List<Object> get props => [type];
}

// Event to search for contacts
class SearchContactsEvent extends PhoneBookEvent {
  final String query;

  const SearchContactsEvent(this.query);

  @override
  List<Object> get props => [query];
}

// Event to add a new contact
class AddContact extends PhoneBookEvent {
  final Contact contact;

  const AddContact(this.contact);

  @override
  List<Object> get props => [contact];
}

// Event to delete a contact
class DeleteContactEvent extends PhoneBookEvent {
  final int contactId;

  const DeleteContactEvent(this.contactId);

  @override
  List<Object> get props => [contactId];
}
