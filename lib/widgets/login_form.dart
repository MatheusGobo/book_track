import 'package:book_track/widgets/widgets.dart';
import 'package:flutter/material.dart';

class LoginForm extends StatelessWidget {
  const LoginForm({
    Key? key,
    required GlobalKey<FormState> formKey,
    required TextEditingController emailTextController,
    required TextEditingController passwordTextController,
  }) : _formKey = formKey, _emailTextController = emailTextController, _passwordTextController = passwordTextController, super(key: key);

  final GlobalKey<FormState> _formKey;
  final TextEditingController _emailTextController;
  final TextEditingController _passwordTextController;

  @override
  Widget build(BuildContext context) {
    return Form(
        key: _formKey,
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(15.0),
              child: TextFormField(
                controller: _emailTextController,
                decoration: buildInputDecoration(label: 'Enter E-mail', hintText: 'john@me.com'),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(15.0),
              child: TextFormField(
                controller: _passwordTextController,
                obscureText: true,
                decoration: buildInputDecoration(label: 'password', hintText: ''),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            TextButton(
              onPressed: () {},
              style: TextButton.styleFrom(
                primary: Colors.white,
                padding: EdgeInsets.all(15),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(4)
                ),
                backgroundColor: Colors.amber,
                textStyle: TextStyle(
                  fontSize: 18
                )
              ),
              child: Text('Sign In')
            )
          ],
        ),
      );
  }
}