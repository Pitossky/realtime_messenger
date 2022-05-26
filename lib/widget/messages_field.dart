import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:realtime_messenger/widget/message_bubble.dart';

class MessageField extends StatelessWidget {
  const MessageField({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser;

    return StreamBuilder<QuerySnapshot>(
      stream: FirebaseFirestore.instance
          .collection('chat')
          .orderBy(
            'createdAt',
            descending: true,
          )
          .snapshots(),
      builder: (_, snap) {
        if (snap.connectionState == ConnectionState.waiting) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
        final msgDocs = snap.data!.docs;
        return ListView.builder(
          reverse: true,
          itemCount: msgDocs.length,
          itemBuilder: (_, i) => MessageBubble(
            msgText: msgDocs[i]['text'],
            userStatus: msgDocs[i]['userId'] == user!.uid,
            key: ValueKey(msgDocs[i].id),
            username: msgDocs[i]['username'],
            userImage: msgDocs[i]['userImage'],
          ),
        );
      },
    );
  }
}
