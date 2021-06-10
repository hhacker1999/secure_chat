import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:nigga_chat/models/conversation_model.dart';
import 'package:sizerutil/sizerutil.dart';

class ConversationsWidget extends StatelessWidget {
  final List<ConversationModel> model;
  final String ownName;
  const ConversationsWidget({
    Key? key,
    required this.model,
    required this.ownName,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 94.h,
      width: 94.w,
      color: Colors.black,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Text(
            'Good morning, $ownName',
            style: TextStyle(
              fontSize: 20.f,
              color: Colors.grey[600],
              fontWeight: FontWeight.w700,
            ),
          ),
          SizedBox(
            height: 2.h,
          ),
          Text(
            'Your messages',
            style: TextStyle(
              fontSize: 42.f,
              color: Colors.white,
              fontWeight: FontWeight.w600,
            ),
          ),
          SizedBox(
            height: 10.h,
          ),
          Expanded(
            child: ListView.builder(
              itemCount: model.length,
              itemBuilder: (_, index) => ConversationCard(
                  otherPartyName: model[index].name,
                  message: model[index].message),
            ),
          ),
        ],
      ),
    );
  }
}

class ConversationCard extends StatelessWidget {
  final String otherPartyName;
  final String message;
  const ConversationCard({
    Key? key,
    required this.otherPartyName,
    required this.message,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          CircleAvatar(
            radius: 40.f,
            backgroundColor: Colors.black,
            child: (SvgPicture.asset('assets/user.svg')),
          ),
          SizedBox(
            width: 10,
          ),
          Flexible(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  otherPartyName,
                  style: TextStyle(
                    fontSize: 21.f,
                    color: Colors.white,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Text(
                  message,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    fontSize: 18.f,
                    color: Colors.grey[600],
                    fontWeight: FontWeight.w600,
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
