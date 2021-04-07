import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fridge/themes.dart';

class ActionBar extends StatelessWidget {
  const ActionBar({
    Key key,
    @required this.text,
    @required this.onPressed,
    this.onPressedMinus,
    this.onPressedPlus,
  }) : super(key: key);

  final String text;
  final GestureTapCallback onPressed, onPressedMinus, onPressedPlus;

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: 0,
      child: Row(
        children: [
          ActionButton(onPressed: onPressed, text: text),
          SizedBox(width: 24),
          FilterButton(
            icon: Icons.remove,
            onPressed: onPressedMinus,
            iconColor: Theme.of(context).errorColor,
            bgColor: AppColors.RED_n254,
          ),
          SizedBox(width: 12),
          FilterButton(
            icon: Icons.add,
            onPressed: onPressedPlus,
            iconColor: Theme.of(context).primaryColor,
            bgColor: Theme.of(context).accentColor,
          ),
        ],
      ),
    );
  }
}

class FilterButton extends StatelessWidget {
  const FilterButton({
    Key key,
    @required this.onPressed,
    @required this.icon,
    @required this.iconColor,
    @required this.bgColor,
  }) : super(key: key);

  final Function onPressed;
  final IconData icon;
  final Color iconColor;
  final Color bgColor;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressed,
      borderRadius: BorderRadius.circular(16),
      highlightColor: Theme.of(context).primaryColor.withOpacity(.2),
      child: Container(
        padding: EdgeInsets.symmetric(
          horizontal: 12,
          vertical: 12,
        ),
        decoration: BoxDecoration(
          color: bgColor,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Icon(
          icon,
          color: iconColor,
        ),
      ),
    );
  }
}

class ActionButton extends StatelessWidget {
  const ActionButton({
    Key key,
    @required this.onPressed,
    @required this.text,
  }) : super(key: key);

  final Function onPressed;
  final String text;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressed,
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
                  color:
                      Theme.of(context).colorScheme.secondary.withOpacity(.20))
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
    );
  }
}
