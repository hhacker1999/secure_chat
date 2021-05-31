part of 'contactsview_model.dart';

abstract class ContactsviewEvent extends Equatable {
  const ContactsviewEvent();

  @override
  List<Object> get props => [];
}

class GetContactsListEvent extends ContactsviewEvent {}

class NavigateToChatViewEvent extends ContactsviewEvent {
  final ContactModel model;

  const NavigateToChatViewEvent({required this.model});
}
