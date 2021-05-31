import 'package:flutter/material.dart';
import 'package:flutter_view_model/flutter_view_model.dart';
import 'package:sizerutil/sizerutil.dart';
import 'package:nigga_chat/app/locator.dart';
import 'package:nigga_chat/views/contacts_view/contacts_view.dart';
import 'package:nigga_chat/views/homeview/home_view_model/homeviewmodel.dart';
import 'helper_widgets/conversation_widget.dart';
import 'helper_widgets/no_conversatio_widget.dart';

class HomeView extends StatelessWidget {
  final Homeviewmodel _model = locator<Homeviewmodel>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () => Navigator.push(
            context, MaterialPageRoute(builder: (context) => ContactsView())),
      ),
      backgroundColor: Colors.black,
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(6.w),
          child: ModelBuilder<HomeviewmodelState, Homeviewmodel>(
              model: _model,
              builder: (context, state) {
                if (state is HomeviewmodelLoading)
                  return Center(child: CircularProgressIndicator());
                else if (state is HomeviewLoadedwithNoData)
                  return NoConversationWidget(name: state.userModel.name);
                else if (state is HomeviewLoadedwithData)
                  return ConversationsWidget(
                      model: state.conversationModel,
                      ownName: state.userModel.name);
                else
                  return CircularProgressIndicator();
              }),
        ),
      ),
    );
  }
}
