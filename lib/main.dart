import 'package:book_track/screens/screens.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: const FirebaseOptions(
      apiKey: "AIzaSyDYfUc3y5DCZPu1bGgfKeT2vLTFa2EIo0c",
      appId: "1:768633632456:web:01ceab51567bd5e8a257fd",
      messagingSenderId: "768633632456",
      projectId: "booktrackerapp-e55e2",
    )
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    User? firebaseUser = FirebaseAuth.instance.currentUser;
    Widget widget;
    if (firebaseUser != null) {
      print(firebaseUser.email);
      widget = MainScreenPage();
    } else {
      widget = LoginPage();
    }

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'BookTracker',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: widget,
    );
  }
}

