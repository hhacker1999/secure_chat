import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:sizerutil/sizerutil.dart';


class ChatItem extends StatelessWidget {
  final String message;
  final bool isOther;
  final Timestamp time;

  const ChatItem(
      {Key? key,
      required this.message,
      required this.isOther,
      required this.time})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, c) => Container(
        alignment: Alignment.center,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Container(
              padding: EdgeInsets.all(10),
              width: 70.w,
              child: Text(
                message,
                style: TextStyle(fontSize: 23.f),
              ),
              decoration: BoxDecoration(
                color: isOther ? Color(0xFFF2F2F2) : Color(0xFFEFEEFD),
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(30),
                  bottomRight: Radius.circular(30),
                  topRight: isOther ? Radius.circular(30) : Radius.circular(0),
                  topLeft: isOther ? Radius.circular(0) : Radius.circular(30),
                ),
              ),
            ),
            Text(
              '${time.toDate().toString().substring(0, time.toDate().toString().length - 7)}',
              style: TextStyle(fontSize: 16.f),
            ),
          ],
        ),
      ),
    );
  }
}