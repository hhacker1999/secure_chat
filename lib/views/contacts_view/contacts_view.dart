import 'package:flutter/material.dart';
import 'package:flutter_view_model/flutter_view_model.dart';
import 'package:nigga_chat/app/locator.dart';
import 'package:nigga_chat/views/contacts_view/contacts_view_model/contactsview_model.dart';

class ContactsView extends StatelessWidget {
  final ContactsviewModel _model = locator<ContactsviewModel>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ModelConsumer<ContactsviewState, ContactsviewModel>(
          builder: (context, state) {
            if (state is ContactsViewLoadedWithData)
              return Center(
                child: Text(
                    '${state.modelList[0].phoneNumber} , ${state.modelList[0].name}'),
              );
            else if (state is ContactsViewLoadedWithNoData)
              return Center(
                child: Text('No contacts'),
              );
            else
              return Center(
                child: CircularProgressIndicator(),
              );
          },
          listener: (context, state) {},
          model: _model),
    );
  }
}
