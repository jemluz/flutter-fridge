import 'package:flutter/material.dart';

class GenericDialog extends StatelessWidget {
  const GenericDialog({
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
          child: Text('Fechar'),
          onPressed: () => onPressed,
        )
      ],
    );
  }
}