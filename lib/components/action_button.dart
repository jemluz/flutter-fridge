import 'package:flutter/material.dart';

class ActionButton extends StatelessWidget {
  const ActionButton({
    Key key, 
    @required this.text,
  }) : super(key: key);

  final String text;

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: 0,
      child: InkWell(
        onTap: () {},
        borderRadius: BorderRadius.circular(16),
        highlightColor: Theme.of(context).primaryColor.withOpacity(.2),
        child: Container(
          padding: EdgeInsets.symmetric(
            horizontal: 20,
            vertical: 12,
          ),
          decoration: BoxDecoration(
              color: Theme.of(context).primaryColor,
              borderRadius: BorderRadius.circular(12),
              boxShadow: <BoxShadow>[
                BoxShadow(
                    offset: Offset(0, 0),
                    blurRadius: 30,
                    color: Theme.of(context)
                        .colorScheme
                        .secondary
                        .withOpacity(.20))
              ]),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Icon(
                Icons.add,
                color: Colors.white,
              ),
              SizedBox(width: 10),
              Text(
                text,
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.w500),
              ),
              SizedBox(width: 10),
            ],
          ),
        ),
      ),
    );
  }
}
