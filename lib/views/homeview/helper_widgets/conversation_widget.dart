import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:sizerutil/sizerutil.dart';

class ConversationWidget extends StatelessWidget {
  final String phoneNumber;
  final String name;
  final String message;
  final Timestamp time;
  const ConversationWidget({
    Key? key,
    required this.phoneNumber,
    required this.name,
    required this.message,
    required this.time,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 13.h,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        color: Colors.white,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          SizedBox(
            width: 22.w,
            child: CircleAvatar(
              child: Icon(Icons.person),
              radius: 35.f,
              backgroundColor: Color(0xff2F23A4),
            ),
          ),
          SizedBox(
            width: 2.w,
            child: VerticalDivider(
              thickness: 3,
            ),
          ),
          SizedBox(
            width: 65.w,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '$name($phoneNumber)',
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                      color: Colors.black),
                ),
                SizedBox(
                  height: 2.5.h,
                ),
                Text(
                  '(${time.toDate().toString().substring(0, time.toDate().toString().length - 7)}) $message',
                  style: TextStyle(
                    fontSize: 18.f,
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
