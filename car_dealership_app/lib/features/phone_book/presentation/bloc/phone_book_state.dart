part of 'phone_book_bloc.dart';

abstract class PhoneBookState extends Equatable {
  const PhoneBookState();

  @override
  List<Object> get props => [];
}

// Initial state, before anything has happened
class PhoneBookInitial extends PhoneBookState {}

// State when contacts are being loaded from the database
class PhoneBookLoading extends PhoneBookState {}

// State when contacts have been successfully loaded
class PhoneBookLoaded extends PhoneBookState {
  final List<Contact> contacts;
  final ContactType? activeFilter; // To know which tab is active

  const PhoneBookLoaded({required this.contacts, this.activeFilter});

  @override
  List<Object> get props => [contacts, activeFilter ?? 'all'];
}

// State when an error occurs
class PhoneBookError extends PhoneBookState {
  final String message;

  const PhoneBookError(this.message);

  @override
  List<Object> get props => [message];
}
