import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class FilterButton extends StatelessWidget {
  const FilterButton({
    Key key,
    @required this.onPressed,
    @required this.icon,
    @required this.iconColor,
    @required this.bgColor,
  }) : super(key: key);

  final Function onPressed;
  final String icon;
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
          horizontal: 22,
          vertical: 16,
        ),
        decoration: BoxDecoration(
          color: bgColor,
          borderRadius: BorderRadius.circular(12),
        ),
        child: SvgPicture.asset(icon, color: iconColor, height: 18,),
      ),
    );
  }
}