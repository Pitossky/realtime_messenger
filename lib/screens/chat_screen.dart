import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:realtime_messenger/widget/message_textfield.dart';
import 'package:realtime_messenger/widget/messages_field.dart';

class ChatScreen extends StatelessWidget {
  const ChatScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: const Text('Realtime Messenger'),
        actions: [
          DropdownButton(
            items: [
              DropdownMenuItem(
                value: 'logout',
                child: Row(
                  children: const [
                    Icon(Icons.exit_to_app),
                    SizedBox(width: 10),
                    Text('Log out'),
                  ],
                ),
              ),
            ],
            onChanged: (val) {
              if (val == 'logout') {
                FirebaseAuth.instance.signOut();
              }
            },
            icon: Icon(
              Icons.more_vert,
              color: Theme.of(context).primaryIconTheme.color,
            ),
          ),
        ],
      ),
      body: Column(
        children: const [
          Expanded(
            child: MessageField(),
          ),
          MessageTextfield(),
        ],
      ),
    );
  }
}
