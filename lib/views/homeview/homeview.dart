import 'package:flutter/material.dart';
import 'package:flutter_view_model/flutter_view_model.dart';
import 'package:sizerutil/sizerutil.dart';

import 'package:nigga_chat/app/app_constants.dart';
import 'package:nigga_chat/app/locator.dart';
import 'package:nigga_chat/views/chat_view/chat_view.dart';
import 'package:nigga_chat/views/homeview/home_view_model/homeviewmodel.dart';

import 'helper_widgets/conversation_widget.dart';

class HomeView extends StatelessWidget {
  final Homeviewmodel _model = locator<Homeviewmodel>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFEBF9FF),
      body: SafeArea(
        child: ModelBuilder<HomeviewmodelState, Homeviewmodel>(
            model: _model,
            builder: (context, state) {
              if (state is HomeviewmodelLoading)
                return Center(child: CircularProgressIndicator());
              else if (state is HomeviewLoadedwithNoData)
                return Center(
                  child: Text('no conversations'),
                );
              else if (state is HomeviewLoadedwithData)
                return Padding(
                  padding: const EdgeInsets.all(22.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        flex: 1,
                        child: Text(
                          'Conversations',
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 38),
                        ),
                      ),
                      Expanded(
                        flex: 1,
                        child: Row(
                          children: [
                            Expanded(
                              flex: 1,
                              child: Card(
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(15)),
                                child: Icon(
                                  Icons.search,
                                  color: Colors.grey,
                                  size: 50,
                                ),
                              ),
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            Expanded(
                              flex: 3,
                              child: Container(
                                  alignment: Alignment.center,
                                  decoration: BoxDecoration(
                                      color: Color(0xff2F23A4),
                                      borderRadius: BorderRadius.circular(15)),
                                  child: Text(
                                    'Active',
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 25,
                                        color: Colors.white),
                                  )),
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            Expanded(
                              flex: 3,
                              child: Container(
                                  alignment: Alignment.center,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(15),
                                      color: Colors.white),
                                  child: Text(
                                    'Archived',
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 25,
                                        color: Colors.black),
                                  )),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 2.h,
                      ),
                      Expanded(
                        flex: 15,
                        child: ListView.builder(
                            itemBuilder: (context, index) {
                              return GestureDetector(
                                onTap: () => Navigator.pushNamed(
                                  context,
                                  AppConstants.chatView,
                                  arguments: ChatViewArguments(
                                      state.model[index].phoneNumber,
                                      state.model[index].name),
                                ),
                                child: ConversationWidget(
                                  phoneNumber: state.model[index].phoneNumber,
                                  message: state.model[index].message,
                                  name: state.model[index].name,
                                  time: state.model[index].time,
                                ),
                              );
                            },
                            itemCount: state.model.length),
                      ),
                    ],
                  ),
                );
              else
                return CircularProgressIndicator();
            }),
      ),
    );
  }
}
