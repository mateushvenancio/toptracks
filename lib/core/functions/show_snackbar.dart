import 'package:flutter/material.dart';

showMainSnackBar(BuildContext context, String content) {
  final snackBar = SnackBar(
    content: Text(content),
    action: SnackBarAction(
      label: 'OK',
      onPressed: () {
        ScaffoldMessenger.of(context).clearSnackBars();
      },
    ),
  );
  ScaffoldMessenger.of(context).showSnackBar(snackBar);
}
