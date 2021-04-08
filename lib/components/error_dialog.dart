import 'package:flutter/material.dart';

class ErrorDialog extends StatelessWidget {
  const ErrorDialog({
    Key key,
    @required this.context,
    @required this.message,
  }) : super(key: key);

  final BuildContext context;
  final String message;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('Ocorreu um erro'),
      content: Text(message),
      actions: [
        TextButton(
          child: Text('Ok'),
          onPressed: () => Navigator.of(context).pop(),
        )
      ],
    );
  }
}