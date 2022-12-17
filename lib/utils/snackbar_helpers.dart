import 'package:flutter/material.dart';

void showErrorSnackBar(BuildContext context, {required String message}) {
  final snackBar = SnackBar(
    content: Text(message),
    backgroundColor: Colors.red,
    //padding: EdgeInsets.symmetric(vertical: 20),
  );
  ScaffoldMessenger.of(context).showSnackBar(snackBar);
}

//success
void showSnackBar(BuildContext context, {required String message}) {
  final snackBar = SnackBar(
    content: Text(
      message,
      style: TextStyle(color: Colors.white, fontWeight: FontWeight.w900),
    ),
    backgroundColor: Colors.grey,

    //padding: EdgeInsets.symmetric(vertical: 20),
  );
  ScaffoldMessenger.of(context).showSnackBar(snackBar);
}
