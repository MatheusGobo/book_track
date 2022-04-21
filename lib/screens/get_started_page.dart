import 'package:book_track/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';

class GetStartedPage extends StatelessWidget {
  const GetStartedPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      child: CircleAvatar(
        backgroundColor: HexColor('#f5f6f8'),
        child: Column(
          children: [
            Spacer(),
            Text(
              'BookTracker',
              style: Theme.of(context).textTheme.headline3,
            ),
            SizedBox(
              height: 15,
            ),
            Text('"Read. Change. Yourself"',
                style: TextStyle(
                    color: Colors.black26,
                    fontSize: 29,
                    fontWeight: FontWeight.bold)),
            SizedBox(
              height: 50,
            ),
            TextButton.icon(
              style: TextButton.styleFrom(
                  primary: Colors.white,
                  backgroundColor: HexColor('#69639f'),
                  textStyle: TextStyle(fontSize: 18)),
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => LoginPage(),
                    ));
              },
              icon: Icon(Icons.login_rounded),
              label: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text('Sing in to get started'),
              ),
            ),
            Spacer()
          ],
        ),
      ),
    );
  }
}

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  bool isCreateAccountClicked = false;
  final _formKey = GlobalKey<FormState>();

  final TextEditingController _emailTextController = TextEditingController();
  final TextEditingController _passwordTextController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Container(
        child: Column(
          children: [
            Expanded(
                flex: 2,
                child: Container(
                  color: HexColor('#b9c2d1'),
                )),
            Text(
              'Sign In',
              style: Theme.of(context).textTheme.headline5,
            ),
            SizedBox(
              height: 10,
            ),
            Column(
              children: [
                SizedBox(
                    width: 300,
                    height: 300,
                    child: isCreateAccountClicked != true
                        ? LoginForm(
                          formKey: _formKey,
                          emailTextController: _emailTextController,
                          passwordTextController: _passwordTextController
                        )
                        : CreateAccountForm(
                          formKey: _formKey,
                          emailTextController: _emailTextController,
                          passwordTextController: _passwordTextController
                        )),
                TextButton.icon(
                    icon: Icon(Icons.portrait_rounded),
                    style: TextButton.styleFrom(
                        primary: HexColor('#fd5b28'),
                        textStyle: TextStyle(
                            fontSize: 18, fontStyle: FontStyle.italic)),
                    onPressed: () {
                      setState(() {
                        //Altera forma do menu entre login ou criar conta
                        isCreateAccountClicked = !isCreateAccountClicked;

                        /*if (!isCreateAccountClicked) {
                        isCreateAccountClicked = true;
                      } else {
                        isCreateAccountClicked = false;
                      }*/
                      });
                    },
                    label: Text(isCreateAccountClicked
                        ? 'Already have an account?'
                        : 'Create Account'))
              ],
            ),
            Expanded(
                flex: 2,
                child: Container(
                  color: HexColor('#b9c2d1'),
                ))
          ],
        ),
      ),
    );
  }

}



