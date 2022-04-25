import 'package:book_track/model/model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class MainScreenPage extends StatelessWidget {
  const MainScreenPage({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    CollectionReference booksCollection = FirebaseFirestore.instance.collection('books');
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white24,
        elevation: 0.0,
        centerTitle: false,
        title: Row(
          children: [
            Text(
              'A.Reader',
              style: Theme.of(context).textTheme.headline6!.copyWith(
                color: Colors.redAccent,
                fontWeight: FontWeight.bold),
            ),
            StreamBuilder <QuerySnapshot> (
              stream: booksCollection.snapshots(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }

                final bookListStream = snapshot.data!.docs.map((book) {
                  return Book.fromDocument(book);
                }).toList();

                //Map<String, dynamic> book = snapshot.data!.docs.first.data() as Map<String, dynamic>;
                return Text(
                  bookListStream[0].author ?? '',
                  style: TextStyle(color: Colors.black)
                );
            },)
          ],
        ),
      ),
      
    );
  }
}