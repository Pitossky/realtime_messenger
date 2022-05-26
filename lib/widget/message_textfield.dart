import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class MessageTextfield extends StatefulWidget {
  const MessageTextfield({Key? key}) : super(key: key);

  @override
  _MessageTextfieldState createState() => _MessageTextfieldState();
}

class _MessageTextfieldState extends State<MessageTextfield> {
  String _msgState = '';
  final _txtControl = TextEditingController();

  void _sendMsg() async {
    FocusScope.of(context).unfocus();
    final appUser = FirebaseAuth.instance.currentUser;
    final userData = await FirebaseFirestore.instance
        .collection('users')
        .doc(appUser!.uid)
        .get();
    FirebaseFirestore.instance.collection('chat').add({
      'text': _msgState,
      'createdAt': Timestamp.now(),
      'userId': appUser.uid,
      'username': userData['username'],
      'userImage': userData['image_url'],
    });
    _txtControl.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 10),
      padding: const EdgeInsets.all(10),
      child: Row(
        children: [
          Expanded(
            child: TextField(
              controller: _txtControl,
              decoration: const InputDecoration(
                labelText: 'Send a message...',
              ),
              onChanged: (val) {
                setState(() {
                  _msgState = val;
                });
              },
            ),
          ),
          IconButton(
            color: Theme.of(context).accentColor,
            onPressed: _msgState.trim().isEmpty ? null : _sendMsg,
            icon: const Icon(Icons.send),
          ),
        ],
      ),
    );
  }
}
