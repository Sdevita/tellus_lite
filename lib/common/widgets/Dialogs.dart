import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Dialogs {
  static showDCustomDialog(BuildContext context, String title,
      String description, List<Widget> actions) {
    showDialog(
        context: context,
        builder: (_) => Platform.isIOS
            ? CupertinoAlertDialog(
                title: new Text(title),
                content: new Text(description),
                actions: actions,
              )
            : AlertDialog(
                title: new Text(title),
                content: new Text(description),
                actions: actions,
              ));
  }

  static showDefaultAlert(BuildContext context) {
    showDCustomDialog(context, "Ops", "something went wrong", <Widget>[
      FlatButton(
        child: Text(
          'Retry',
          style: TextStyle(color: Colors.blueAccent),
        ),
        onPressed: () {
          Navigator.of(context).pop();
        },
      )
    ]);
  }
}
