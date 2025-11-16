import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import '../../data/models/contact_model.dart';
import '../../data/repositories/phone_book_repository.dart';

part 'phone_book_event.dart';
part 'phone_book_state.dart';

class PhoneBookBloc extends Bloc<PhoneBookEvent, PhoneBookState> {
  final PhoneBookRepository _repository;

  PhoneBookBloc(this._repository) : super(PhoneBookInitial()) {
    on<LoadContacts>(_onLoadContacts);
    on<FilterContacts>(_onFilterContacts);
    on<SearchContactsEvent>(_onSearchContacts);
    on<AddContact>(_onAddContact);
    on<DeleteContactEvent>(_onDeleteContact);
  }

  Future<void> _onLoadContacts(LoadContacts event, Emitter<PhoneBookState> emit) async {
    emit(PhoneBookLoading());
    try {
      final contacts = await _repository.getAllContacts();
      emit(PhoneBookLoaded(contacts: contacts, activeFilter: null));
    } catch (e) {
      emit(PhoneBookError(e.toString()));
    }
  }

  Future<void> _onFilterContacts(FilterContacts event, Emitter<PhoneBookState> emit) async {
    emit(PhoneBookLoading());
    try {
      final contacts = await _repository.getContactsByType(event.type);
      emit(PhoneBookLoaded(contacts: contacts, activeFilter: event.type));
    } catch (e) {
      emit(PhoneBookError(e.toString()));
    }
  }

  Future<void> _onSearchContacts(SearchContactsEvent event, Emitter<PhoneBookState> emit) async {
    emit(PhoneBookLoading());
    try {
      final contacts = await _repository.searchContacts(event.query);
      emit(PhoneBookLoaded(contacts: contacts));
    } catch (e) {
      emit(PhoneBookError(e.toString()));
    }
  }

  Future<void> _onAddContact(AddContact event, Emitter<PhoneBookState> emit) async {
    try {
      await _repository.saveContact(event.contact);
      add(LoadContacts()); // Reload all contacts after adding a new one
    } catch (e) {
      emit(PhoneBookError(e.toString()));
    }
  }

  Future<void> _onDeleteContact(DeleteContactEvent event, Emitter<PhoneBookState> emit) async {
    try {
      await _repository.deleteContact(event.contactId);
      add(LoadContacts()); // Reload all contacts after deleting
    } catch (e) {
      emit(PhoneBookError(e.toString()));
    }
  }
}
