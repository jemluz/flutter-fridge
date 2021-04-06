import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../themes.dart';

class MenuButton extends StatelessWidget {
  const MenuButton({
    Key key,
    @required this.onPressed,
    @required this.svgSrc,
    @required this.text,
    this.color,
  }) : super(key: key);

  final Function onPressed;
  final String svgSrc, text;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressed,
      borderRadius: BorderRadius.circular(16),
      highlightColor: Theme.of(context).primaryColor.withOpacity(.2),
      child: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: 12,
          vertical: 16,
        ),
        child: Column(
          children: <Widget>[
            SvgPicture.asset(svgSrc,
                color: color),
            SizedBox(height: 5),
            Text(
              text,
              style: TextStyle(color: color),
            )
          ],
        ),
      ),
    );
  }
}