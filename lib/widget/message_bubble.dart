import 'package:flutter/material.dart';

class MessageBubble extends StatelessWidget {
  final String msgText;

  const MessageBubble({
    Key? key,
    required this.msgText,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          decoration: BoxDecoration(
            color: Theme.of(context).accentColor,
            borderRadius: BorderRadius.circular(10),
          ),
          width: 140,
          padding: const EdgeInsets.symmetric(
            vertical: 10,
            horizontal: 15,
          ),
          margin: const EdgeInsets.symmetric(
            vertical: 5,
            horizontal: 10,
          ),
          child: Text(
            msgText,
            style: TextStyle(
              color: Theme.of(context).accentTextTheme.headline1!.color,
            ),
          ),
        ),
      ],
    );
  }
}
