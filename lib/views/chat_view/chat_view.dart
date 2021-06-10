import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_view_model/flutter_view_model.dart';
import 'package:nigga_chat/app/locator.dart';
import 'package:nigga_chat/views/chat_view/chat_view_model/chat_view_model.dart';
import 'package:sizerutil/sizerutil.dart';

import 'hepler_widgets/chat_item.dart';

class ChatView extends StatefulWidget {
  final String other;
  final String otherName;

  const ChatView({Key? key, required this.other, required this.otherName})
      : super(key: key);
  @override
  _ChatViewState createState() => _ChatViewState();
}

class _ChatViewState extends State<ChatView> {
  late ChatViewModel _model;
  late TextEditingController _controller;
  late ScrollController _controllerScroll;

  @override
  void initState() {
    _controller = TextEditingController();
    _controllerScroll = ScrollController();
    _model = locator<ChatViewModel>();
    _model.add(LoadChatEvent(other: widget.other));

    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFEBF9FF),
      body: SafeArea(
        child: ModelBuilder<ChatViewState, ChatViewModel>(
            builder: (context, state) {
              if (state is ChatViewStateLoading)
                return Center(
                  child: CircularProgressIndicator(),
                );
              else if (state is ChatViewStateLoaded)
                return SingleChildScrollView(
                  child: Container(
                    height: 100.h,
                    padding: const EdgeInsets.all(15.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: <Widget>[
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Icon(
                              Icons.arrow_back,
                              size: 40.f,
                            ),
                            Text(
                              'Conversation with ${widget.otherName}',
                              style: TextStyle(
                                  fontSize: 25.f, fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            CircleAvatar(
                              child: Icon(Icons.person),
                              radius: 27.f,
                              backgroundColor: Color(0xff2F23A4),
                            ),
                            Container(
                              width: 70.w,
                              alignment: Alignment.center,
                              decoration: BoxDecoration(
                                  color: Color(0xff2F23A4),
                                  borderRadius: BorderRadius.circular(15)),
                              height: 5.h,
                              child: Text(
                                'User Details',
                                style: TextStyle(
                                    color: Colors.white, fontSize: 25),
                              ),
                            ),
                          ],
                        ),
                        Container(
                          padding: const EdgeInsets.all(10),
                          alignment: Alignment.center,
                          height: 70.h,
                          width: double.infinity,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(30),
                          ),
                          child: Column(
                            children: [
                              Expanded(
                                child: ListView.separated(
                                  reverse: true,
                                  controller: _controllerScroll,
                                  scrollDirection: Axis.vertical,
                                  shrinkWrap: true,
                                  itemBuilder: (context, index) {
                                    
                                    return ChatItem(
                                        message: state.model[index].message,
                                        isOther: widget.other ==
                                            state.model[index].sentBy,
                                        time: state.model[index].time);
                                  },
                                  separatorBuilder: (context, index) {
                                    return SizedBox(
                                      height: 10,
                                    );
                                  },
                                  itemCount: state.model.length,
                                ),
                              ),
                              TextField(
                                maxLines: 1,
                                controller: _controller,
                                decoration: InputDecoration(
                                  suffixIcon: InkWell(
                                    onTap: () {
                                      if (_controller.text.isNotEmpty) {
                                        _model.add(
                                          SendMessageEvent(
                                            other: widget.other,
                                            message: _controller.text,
                                            time: Timestamp.fromDate(
                                              DateTime.now(),
                                            ),
                                          ),
                                        );
                                        _controller.clear();
                                        FocusScope.of(context).unfocus();
                                      }
                                    },
                                    child: CircleAvatar(
                                      backgroundColor: Color(0xff2F23A4),
                                      child: Icon(
                                        Icons.send,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ),
                                  fillColor: Color(0xFFF2F2F2),
                                  filled: true,
                                  enabledBorder: OutlineInputBorder(
                                      borderSide:
                                          BorderSide(color: Colors.white),
                                      borderRadius: BorderRadius.circular(30)),
                                  disabledBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                          color: Colors.red, width: 20),
                                      borderRadius: BorderRadius.circular(30)),
                                  hintText: 'Write Your message here',
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              else if (state is ChatViewLoadedwithNoData)
                return Center(
                  child: Text('please chat'),
                );
              else
                return Center(
                  child: CircularProgressIndicator(),
                );
            },
            model: _model),
      ),
    );
  }
}



class ChatViewArguments {
  final String other;
  final String otherName;
  const ChatViewArguments(this.other, this.otherName);
}
