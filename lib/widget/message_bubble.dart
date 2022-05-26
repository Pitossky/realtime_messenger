import 'package:flutter/material.dart';
//import 'package:cloud_firestore/cloud_firestore.dart';

class MessageBubble extends StatelessWidget {
  final String msgText;
  final bool userStatus;
  final String username;
  final String userImage;

  const MessageBubble({
    required Key key,
    required this.msgText,
    required this.userStatus,
    required this.username,
    required this.userImage,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      clipBehavior: Clip.none,
      children: [
        Row(
          mainAxisAlignment:
          userStatus ? MainAxisAlignment.end : MainAxisAlignment.start,
          children: [
            Container(
              decoration: BoxDecoration(
                color: userStatus
                    ? Theme.of(context).primaryColor
                    : Theme.of(context).accentColor,
                borderRadius: BorderRadius.only(
                  topLeft: const Radius.circular(10),
                  topRight: const Radius.circular(10),
                  bottomLeft: userStatus
                      ? const Radius.circular(0)
                      : const Radius.circular(10),
                  bottomRight: !userStatus
                      ? const Radius.circular(0)
                      : const Radius.circular(10),
                ),
              ),
              width: 140,
              padding: const EdgeInsets.symmetric(
                vertical: 10,
                horizontal: 15,
              ),
              margin: const EdgeInsets.symmetric(
                vertical: 15,
                horizontal: 10,
              ),
              child: Column(
                crossAxisAlignment:
                userStatus ? CrossAxisAlignment.end : CrossAxisAlignment.start,
                children: [
                  Text(
                    username,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: userStatus
                          ? Colors.black
                          : Theme.of(context).accentTextTheme.headline1!.color,
                    ),
                    //textAlign: TextAlign.right,
                  ),
                  Text(
                    msgText,
                    style: TextStyle(
                      color: userStatus
                          ? Colors.black
                          : Theme.of(context).accentTextTheme.headline1!.color,
                    ),
                    textAlign: userStatus ? TextAlign.end : TextAlign.start,
                  ),
                ],
              ),
            ),
          ],
        ),
        Positioned(
          top: 0,
          left: userStatus ? null : 130,
          right: userStatus ? 130 : null,
          child: CircleAvatar(
            backgroundColor: Colors.red,
            backgroundImage: NetworkImage(userImage),
          ),
        ),
      ],
    );
  }
}
