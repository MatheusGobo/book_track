import 'package:book_track/screens/screens.dart';
import 'package:book_track/widgets/widgets.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

class CreateAccountForm extends StatelessWidget {
  const CreateAccountForm({
    Key? key,
    required GlobalKey<FormState> formKey,
    required TextEditingController emailTextController,
    required TextEditingController passwordTextController,
  })  : _formKey = formKey,
        _emailTextController = emailTextController,
        _passwordTextController = passwordTextController,
        super(key: key);

  final GlobalKey<FormState> _formKey;
  final TextEditingController _emailTextController;
  final TextEditingController _passwordTextController;

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          const Text(
              'Please enter a valide email and a password that is at least 6 character.'),
          Padding(
            padding: const EdgeInsets.all(15.0),
            child: TextFormField(
              validator: (value) {
                return value!.isEmpty ? 'Please add an email' : null;
              },
              controller: _emailTextController,
              decoration: buildInputDecoration(
                  label: 'Enter E-mail', hintText: 'john@me.com'),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(15.0),
            child: TextFormField(
              validator: (value) {
                if (value!.isEmpty) {
                  return 'Enter password';
                }

                if (value.length < 6) {
                  return 'Password must be 6 characters';
                }

                return null;
              },
              controller: _passwordTextController,
              obscureText: true,
              decoration: buildInputDecoration(label: 'password', hintText: ''),
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          TextButton(
              onPressed: () {
                if (_formKey.currentState!.validate()) {
                  String email = _emailTextController.text;

                  //matheus@gmail.com
                  FirebaseAuth.instance
                      .createUserWithEmailAndPassword(
                          email: email, password: _passwordTextController.text)
                      .then((value) {
                    if (value.user != null) {
                      String displayName = email.toString().split('@')[0];
                      createUser(displayName, context).then((value) {
                        FirebaseAuth.instance
                            .signInWithEmailAndPassword(
                                email: _emailTextController.text,
                                password: _passwordTextController.text)
                            .then((value) {
                          return Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => MainScreenPage(),
                              ));
                        });
                      });
                    }
                  });
                }
              },
              style: TextButton.styleFrom(
                  primary: Colors.white,
                  padding: const EdgeInsets.all(15),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(4)),
                  backgroundColor: Colors.amber,
                  textStyle: const TextStyle(fontSize: 18)),
              child: const Text('Create Account'))
        ],
      ),
    );
  }

  Future<void> createUser(String displayName, BuildContext context) async {
    final userCollectionReference =
        FirebaseFirestore.instance.collection('users');

    FirebaseAuth auth = FirebaseAuth.instance;
    String uid = auth.currentUser!.uid;

    Map<String, dynamic> user = {
      'avatar_url': null,
      'display_name': displayName,
      'profession': null,
      'quotes': null,
      'uid': uid
    };

    userCollectionReference.add(user);
  }
}