import 'package:flutter/material.dart';
import 'package:sizerutil/sizerutil.dart';

class NoConversationWidget extends StatelessWidget {
  final String name;
  const NoConversationWidget({
    Key? key,
    required this.name,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 30.h,
      width: 94.w,
      color: Colors.black,
      child: LayoutBuilder(
        builder: (_, c) => Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'Good morning, $name',
              style: TextStyle(fontSize: 20.f, color: Colors.grey[600]),
            ),
            SizedBox(
              height: c.maxHeight * .10,
            ),
            Text(
              'You have no',
              style: TextStyle(fontSize: 40.f, color: Colors.grey[600]),
            ),
            SizedBox(
              height: c.maxHeight * .10,
            ),
            Text('conversations yet',
                style: TextStyle(fontSize: 40.f, color: Colors.grey[600]))
          ],
        ),
      ),
    );
  }
}