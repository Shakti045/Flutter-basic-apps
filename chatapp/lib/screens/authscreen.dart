import 'dart:io';

import 'package:chatapp/widgets/imagepicker.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';

class AuthScreen extends StatefulWidget {
  const AuthScreen({super.key});

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  bool _loginmode = true;
  bool _loading = false;
  File? _pickedimage;
  String _email = '';
  String _password = '';
  final formkey = GlobalKey<FormState>();

  void _submitform() async {
    final validate = formkey.currentState!.validate();
    if (!validate || (!_loginmode && _pickedimage == null)) {
      ScaffoldMessenger.of(context).clearSnackBars();
      ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Please enter all required field')));
      return;
    }
    formkey.currentState!.save();
    FocusScope.of(context).unfocus();
    try {
      setState(() {
        _loading = true;
      });

      if (_loginmode) {
        final userdetails = await FirebaseAuth.instance
            .signInWithEmailAndPassword(email: _email, password: _password);
      } else {
        final userdetails = await FirebaseAuth.instance
            .createUserWithEmailAndPassword(email: _email, password: _password);
        final firebasestorageref = FirebaseStorage.instance
            .ref()
            .child('user_profile_photos')
            .child('${userdetails.user!.uid}.jpg');
        await firebasestorageref.putFile(_pickedimage!);
        final url = await firebasestorageref.getDownloadURL();
        final firestoreinstance = FirebaseFirestore.instance
            .collection('users')
            .doc(userdetails.user!.uid);
        await firestoreinstance.set({
          "email":userdetails.user!.email,
          "profileurl":url
        });
      }
    } on FirebaseAuthException catch (error) {
      if (context.mounted) {
        ScaffoldMessenger.of(context).clearSnackBars();
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text(error.message!)));
      }
    } finally {
      formkey.currentState!.reset();
      setState(() {
        _loading = false;
      });
    }
  }

  void setpickedimage(File image) {
    _pickedimage = image;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:
            Text(_loginmode ? 'Login to your account' : 'Create a new account'),
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(12),
            child: Container(
              padding: const EdgeInsets.all(15),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: Colors.white,
              ),
              child: Form(
                  key: formkey,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Image.asset(
                        'image/chat.png',
                        width: 100,
                        height: 100,
                      ),
                      if (!_loginmode) ImageInput(setpickedimage),
                      TextFormField(
                        validator: (value) {
                          if (value == null ||
                              value.trim().isEmpty ||
                              !value.contains('@')) {
                            return 'Enter a valid email id';
                          }
                          return null;
                        },
                        onSaved: (value) {
                          _email = value!;
                        },
                        keyboardType: TextInputType.emailAddress,
                        spellCheckConfiguration:
                            const SpellCheckConfiguration.disabled(),
                        autocorrect: false,
                        textCapitalization: TextCapitalization.none,
                        decoration: InputDecoration(
                          hintText: 'Enter your email id',
                          enabledBorder: UnderlineInputBorder(
                            borderSide: BorderSide(
                                color: const Color.fromARGB(255, 29, 5, 189)
                                    .withOpacity(0.5),
                                width: 2),
                            // Change border color
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      TextFormField(
                        validator: (value) {
                          if (value == null ||
                              value.trim().isEmpty ||
                              value.trim().length < 6) {
                            return 'Enter a valid password with minimum 6 charachter';
                          }
                          return null;
                        },
                        onSaved: (value) {
                          _password = value!;
                        },
                        obscureText: true,
                        decoration: InputDecoration(
                          hintText: 'Enter your password',
                          enabledBorder: UnderlineInputBorder(
                            borderSide: BorderSide(
                                color: const Color.fromARGB(255, 29, 5, 189)
                                    .withOpacity(0.5),
                                width: 2),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      _loading
                          ? const Center(
                              child: CircularProgressIndicator(),
                            )
                          : Column(
                              children: [
                                ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                        backgroundColor: const Color.fromARGB(
                                                255, 29, 5, 189)
                                            .withOpacity(0.5),
                                        minimumSize:
                                            const Size(double.infinity, 45)),
                                    onPressed: _submitform,
                                    child: Text(
                                      _loginmode
                                          ? 'Continue login'
                                          : 'Continue create account',
                                      style:
                                          const TextStyle(color: Colors.white),
                                    )),
                                const SizedBox(
                                  height: 10,
                                ),
                                ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                        backgroundColor: const Color.fromARGB(
                                                255, 29, 5, 189)
                                            .withOpacity(0.5),
                                        minimumSize:
                                            const Size(double.infinity, 45)),
                                    onPressed: () {
                                      setState(() {
                                        _loginmode = !_loginmode;
                                      });
                                    },
                                    child: Text(
                                      _loginmode
                                          ? 'No account ? Create a new one'
                                          : 'I have account already',
                                      style:
                                          const TextStyle(color: Colors.white),
                                    ))
                              ],
                            )
                    ],
                  )),
            ),
          ),
        ),
      ),
    );
  }
}
