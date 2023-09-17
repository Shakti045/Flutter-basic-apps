import 'package:chatapp/screens/newmessage.dart';
import 'package:chatapp/widgets/message.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class ChatScreen extends StatelessWidget {
  const ChatScreen({super.key});

  @override
  Widget build(BuildContext context) {
    
    return Scaffold(
      
      appBar: AppBar(
        title: Text(FirebaseAuth.instance.currentUser!.email ?? 'Chat screen'),
        
        actions: [
          IconButton(
              onPressed: () { 
                FirebaseAuth.instance.signOut();
              },
              icon: const Icon(Icons.logout))
        ],
      ),
      body:  Padding(
            padding: const EdgeInsets.all(10),
          child: Column(
            children: [
                
               Expanded(child: Message()),
               const NewMessage(),
            ],
          ),
        ),
    );
  }
}
