import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class NewMessage extends StatefulWidget {
  const NewMessage({super.key});

  @override
  State<NewMessage> createState() {
    return _NewMessageState();
  }
}

class _NewMessageState extends State<NewMessage> {
  final _messagecontroller = TextEditingController();

  @override
  void dispose() {
    _messagecontroller.dispose();
    super.dispose();
  }

  void _sendmessage() async {
    if (_messagecontroller.text.isEmpty) {
      return;
    }
    String message = _messagecontroller.text;
    _messagecontroller.clear();
    await FirebaseFirestore.instance.collection('chats').doc().set({
      "message": message,
      "sender": FirebaseAuth.instance.currentUser!.uid,
      "createdat": Timestamp.now()
    });
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: TextField(
            autocorrect: false,
            enableSuggestions: true,
            textCapitalization: TextCapitalization.sentences,
            spellCheckConfiguration: const SpellCheckConfiguration.disabled(),
            decoration: const InputDecoration(
                hintText: 'Enter your message',
                focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.white))),
            controller: _messagecontroller,
          ),
        ),
        IconButton(
            onPressed: _sendmessage,
            icon: const Icon(
              Icons.telegram,
              size: 40,
            ))
      ],
    );
  }
}
