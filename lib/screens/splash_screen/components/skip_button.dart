import 'package:flutter/material.dart';

import '../../../themes.dart';

class SkipButton extends StatelessWidget {
  const SkipButton({
    Key key,
    @required this.size,
  }) : super(key: key);

  final Size size;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () =>
          Navigator.pushNamed(context, '/home_screen'),
      borderRadius: BorderRadius.circular(8),
      child: Container(
        width: size.width * .26,
        padding: EdgeInsets.symmetric(vertical: 12),
        decoration: BoxDecoration(
            color: AppColors.GREEN_n234,
            borderRadius: BorderRadius.circular(8)),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Pular',
              style: TextStyle(
                  fontSize: 20, color: AppColors.GREEN_n0),
            ),
            SizedBox(width: 8),
            Icon(
              Icons.arrow_forward_ios,
              color: AppColors.GREEN_n0,
              size: 16,
            ),
          ],
        ),
      ),
    );
  }
}