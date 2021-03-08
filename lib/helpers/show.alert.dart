import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

showAlert(BuildContext context, String title, String subtitle) {
  if (Platform.isAndroid) {
    return showDialog(
        context: context,
        builder: (_) => AlertDialog(
              title: Text(title),
              content: Text(subtitle),
              actions: [
                MaterialButton(
                    elevation: 5,
                    textColor: Colors.blue,
                    child: Text("Ok"),
                    onPressed: () => Navigator.pop(context))
              ],
            ));
  }

  showCupertinoDialog(
      context: null,
      builder: (_) => CupertinoAlertDialog(
            title: Text(title),
            content: Text(subtitle),
            actions: [
              CupertinoDialogAction(
                  isDefaultAction: true,
                  child: Text("Ok"),
                  onPressed: () => Navigator.pop(context))
            ],
          ));
}
