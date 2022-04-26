import 'package:book_track/model/model.dart';
import 'package:book_track/screens/screens.dart';
import 'package:book_track/widgets/widgets.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class MainScreenPage extends StatelessWidget {
  const MainScreenPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    CollectionReference userCollection =
        FirebaseFirestore.instance.collection('users');

    //final TextEditingController _displayNameTextController = TextEditingController();
    //final TextEditingController _professionTextController = TextEditingController();
    //final TextEditingController _quoteTextController = TextEditingController();
    //final TextEditingController _avatarTextController = TextEditingController();
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white24,
        elevation: 0.0,
        centerTitle: false,
        toolbarHeight: 77,
        title: Row(
          children: [
            Text(
              'A.Reader',
              style: Theme.of(context).textTheme.headline6!.copyWith(
                  color: Colors.redAccent, fontWeight: FontWeight.bold),
            ),
          ],
        ),
        actions: [
          StreamBuilder<QuerySnapshot>(
            stream: userCollection.snapshots(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }
              final userListStream = snapshot.data!.docs.map((user) {
                return MUser.fromDocument(user);
              }).where((user) {
                return (user.uid == FirebaseAuth.instance.currentUser!.uid);
              }).toList(); //[user]

              MUser currUser = userListStream[0];

              return Column(
                children: [
                  SizedBox(
                    height: 40,
                    width: 40,
                    child: InkWell(
                      child: CircleAvatar(
                        radius: 60,
                        backgroundImage: NetworkImage(currUser.avatarUrl != null
                            ? currUser.avatarUrl.toString()
                            : 'https://i.pravatar.cc/300'),
                        backgroundColor: Colors.white,
                        child: Text(''),
                      ),
                      onTap: () {
                        showDialog(
                            context: context,
                            builder: (context) {
                              return createProfileDialog(context, currUser);
                            });
                      },
                    ),
                  ),
                  Text(
                    currUser.displayName.toString().toUpperCase(),
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(color: Colors.black),
                  )
                ],
              );
            },
          ),
          TextButton.icon(
              onPressed: () {
                FirebaseAuth.instance.signOut().then((value) {
                  return Navigator.push(context,
                      MaterialPageRoute(builder: (context) => LoginPage()));
                });
              },
              icon: Icon(Icons.logout),
              label: Text(''))
        ],
      ),
    );
  }
}