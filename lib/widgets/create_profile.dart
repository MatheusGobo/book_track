import 'package:book_track/model/model.dart';
import 'package:book_track/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';

Widget createProfileDialog(BuildContext context, MUser currUser) {
    final TextEditingController _displayNameTextController = TextEditingController(text: currUser.displayName);
    final TextEditingController _professionTextController  = TextEditingController(text: currUser.profession);
    final TextEditingController _quoteTextController       = TextEditingController(text: currUser.quotes);
    final TextEditingController _avatarTextController      = TextEditingController(text: currUser.avatarUrl);

  return AlertDialog(
        content: Container(
            child: Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircleAvatar(
              backgroundColor: Colors.transparent,
              backgroundImage: NetworkImage(currUser.avatarUrl != null
                  ? currUser.avatarUrl.toString()
                  : 'https://i.pravatar.cc/300'),
              radius: 50,
            )
          ],
        ),
        Text(
          'Books Read',
          style: Theme.of(context)
              .textTheme
              .bodyText1!
              .copyWith(color: Colors.redAccent),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                currUser.displayName.toString().toUpperCase(),
                style: Theme.of(context).textTheme.subtitle1,
              ),
            ),
            TextButton.icon(
                onPressed: () {
                  showDialog(
                      context: context,
                      builder: (context) {
                        return UpdateUserProfile(
                          user: currUser,
                          displayNameTextController: _displayNameTextController,
                          professionTextController: _professionTextController,
                          quoteTextController: _quoteTextController,
                          avatarTextController: _avatarTextController
                        );
                      });
                },
                icon: const Icon(
                  Icons.mode_edit,
                  color: Colors.black12,
                ),
                label: const Text(''))
          ],
        ),
        Text(
          '${currUser.profession}',
          style: Theme.of(context).textTheme.subtitle2,
        ),
        SizedBox(
          width: 100,
          height: 2,
          child: Container(
            color: Colors.red,
          ),
        ),
        const SizedBox(
          height: 10,
        ),
        Container(
          decoration: BoxDecoration(
              border: Border.all(width: 1, color: Colors.blueGrey.shade100),
              color: HexColor('#f1f3f6'),
              borderRadius: BorderRadius.all(Radius.circular(4))),
          child: SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: Column(
              children: [
                Text(
                  'Favorite Quote:',
                  style: TextStyle(color: Colors.black),
                ),
                SizedBox(
                  width: 100,
                  height: 2,
                  child: Container(
                    color: Colors.black,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Center(
                    child: Text(
                      currUser.quotes == null
                          ? 'Favorite book quote: Life is great...'
                          : ' \" ${currUser.quotes} \"',
                      style: Theme.of(context)
                          .textTheme
                          .bodyText2!
                          .copyWith(fontStyle: FontStyle.italic),
                    ),
                  ),
                )
              ],
            ),
          ),
        )
      ],
    )
    )
    
  );
}