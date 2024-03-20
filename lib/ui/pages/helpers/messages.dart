import 'package:flutter/material.dart';
import '../../../config/routes/app_routes.dart';

void showMessage(BuildContext context, String title, String message) {
  showDialog<void>(
    context: context,
    barrierDismissible: true,
    builder: (BuildContext context) {
      return AlertDialog(
        actions: <Widget>[
          TextButton(
            style: TextButton.styleFrom(
              side: const BorderSide(
                color: Colors.black38,
              ),
            ),
            onPressed: () {
              Navigator.of(context).pushNamed(AppRoutes.home);
            },
            child: Text('OK'),
          ),
        ],
        title: Text(title),
        content: SingleChildScrollView(
          child: Text(message),
        ),
      );
    },
  );
}

void showConfirm(BuildContext context, String title, String message,
    Function onOkayPressed) {
  showDialog<void>(
    context: context,
    barrierDismissible: true,
    builder: (BuildContext context) {
      return AlertDialog(
        actions: <Widget>[
          TextButton(
            style: TextButton.styleFrom(
              side: const BorderSide(
                color: Colors.black38,
              ),
            ),
            onPressed: () {
              Navigator.of(context).pop();
              onOkayPressed();
            },
            child: Text('OK'),
          ),
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            style: TextButton.styleFrom(
              side: const BorderSide(
                color: Colors.black38,
              ),
            ),
            child: Text('Cancelar'),
          ),
        ],
        title: Text(title),
        content: SingleChildScrollView(
          child: Text(message),
        ),
      );
    },
  );
}