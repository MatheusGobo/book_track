import 'package:book_track/widgets/widgets.dart';
import 'package:flutter/material.dart';

class CreateAccountForm extends StatelessWidget {
  const CreateAccountForm({
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
            Text('Please enter a valide email and a password that is at least 6 character.'

            ),
            Padding(
              padding: const EdgeInsets.all(15.0),
              child: TextFormField(
                validator: (value) {
                  return value!.isEmpty ? 'Please add an email' : null;
                },
                controller: _emailTextController,
                decoration: buildInputDecoration(label: 'Enter E-mail', hintText: 'john@me.com'),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(15.0),
              child: TextFormField(
                validator: (value) {
                  if(value!.isEmpty) {
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
            SizedBox(
              height: 20,
            ),
            TextButton(
              onPressed: () {
                if (_formKey.currentState!.validate()){

                }
              },
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
              child: Text('Create Account')
            )
          ],
        ),
      );
  }
}