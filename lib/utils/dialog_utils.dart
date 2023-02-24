import 'package:biometric_auth_frontend/generated/l10n.dart';
import 'package:flutter/material.dart';

class DialogUtils {
  static Future<void> showErrorDialog(
      BuildContext context, String message) async {
    return showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(S.of(context).dialogErrorTitle),
          content: SingleChildScrollView(
            child: ListBody(
              children: [
                Text(message),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: Text(S.of(context).dialogOkButton),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
}
