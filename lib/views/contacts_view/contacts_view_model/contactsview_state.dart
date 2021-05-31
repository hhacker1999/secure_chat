part of 'contactsview_model.dart';

abstract class ContactsviewState extends Equatable {
  const ContactsviewState();

  @override
  List<Object> get props => [];
}

class ContactsviewInitial extends ContactsviewState {}

class ContactsViewLoadedWithData extends ContactsviewState {
  final List<ContactModel> modelList;

  const ContactsViewLoadedWithData({required this.modelList});
}

class ContactsViewLoadedWithNoData extends ContactsviewState{}