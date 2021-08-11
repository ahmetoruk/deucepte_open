import 'package:flutter/material.dart';

void showAlertDialog(BuildContext context,
    {required String title,
    required String content,
    required VoidCallback onConfirm}) {
  final actions = <Widget>[
    TextButton(
      onPressed: onConfirm,
      child: const Text('Tamam'),
    ),
    TextButton(
      onPressed: () => Navigator.of(context).pop(),
      child: const Text('İptal'),
    )
  ];
  final alert = AlertDialog(
    title: Text(title),
    content: Text(content),
    actions: actions,
  );

  showDialog<bool>(
    context: context,
    builder: (BuildContext context) {
      return alert;
    },
  );
}
