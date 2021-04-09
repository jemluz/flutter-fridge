import 'package:flutter/material.dart';

class ConfirmDialog extends StatelessWidget {
  const ConfirmDialog({
    Key key,
    @required this.context,
    @required this.message,
    @required this.title,
    @required this.onPressed,
  }) : super(key: key);

  final BuildContext context;
  final String message, title;
  final Function onPressed;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(title),
      content: Text(message),
      actions: [
        TextButton(
          child: Text('Não'),
          onPressed: () => Navigator.of(context).pop(),
        ),
        TextButton(
          child: Text('Sim'),
          onPressed: () => onPressed,
        )
      ],
    );
  }
}