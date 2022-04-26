
import 'package:book_track/model/model.dart';
import 'package:book_track/widgets/widgets.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class UpdateUserProfile extends StatelessWidget {
  const UpdateUserProfile({
    Key? key,
    required this.user,
    required TextEditingController displayNameTextController,
    required TextEditingController professionTextController,
    required TextEditingController quoteTextController,
    required TextEditingController avatarTextController, 
  }) : _displayNameTextController = displayNameTextController, _professionTextController = professionTextController, _quoteTextController = quoteTextController, _avatarTextController = avatarTextController, super(key: key);

  final MUser user;
  final TextEditingController _displayNameTextController;
  final TextEditingController _professionTextController;
  final TextEditingController _quoteTextController;
  final TextEditingController _avatarTextController;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Center(
        child: Text('Edit ${user.displayName}'),
      ),
      content: Form(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: CircleAvatar(
                  backgroundColor: Colors.transparent,
                  backgroundImage: NetworkImage(
                      user.avatarUrl != null
                          ? user.avatarUrl.toString()
                          : 'https://i.pravatar.cc/300'),
                  radius: 50,
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                    controller: _displayNameTextController,
                    decoration: buildInputDecoration(
                        label: 'Your name', hintText: '')),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                    controller: _professionTextController,
                    decoration: buildInputDecoration(
                        label: 'Profession', hintText: '')),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                    controller: _quoteTextController,
                    decoration: buildInputDecoration(
                        label: 'Favorite quote',
                        hintText: '')),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                    controller: _avatarTextController,
                    decoration: buildInputDecoration(
                        label: 'Avatar url', hintText: '')),
              )
            ],
          ),
        ),
      ),
      actions: [
        TextButton(
          onPressed: () {
            final userChangedName       = user.displayName != _displayNameTextController.text;
            final userChangedProfession = user.profession  != _professionTextController.text;
            final userChangedQuote      = user.quotes      != _quoteTextController.text;
            final userChangedAvatar     = user.avatarUrl   != _avatarTextController.text;

            final userNeedUpdate = userChangedName || userChangedProfession || userChangedQuote || userChangedAvatar;

            if (userNeedUpdate) {
              FirebaseFirestore.instance
                .collection('users')
                .doc(user.id)
                .update(
                  MUser(
                    uid: user.uid,
                    displayName: _displayNameTextController.text,
                    profession: _professionTextController.text,
                    quotes: _quoteTextController.text,
                    avatarUrl: _avatarTextController.text
                  ).toMap());
            }

            Navigator.pop(context);
          }, 
          child: Text('Update')
        ),
        TextButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: Text('Cancel'))
      ],
    );
  }
}
