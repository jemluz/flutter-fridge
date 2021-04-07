import 'package:flutter/material.dart';

import '../../themes.dart';

class FilterTag extends StatelessWidget {
  const FilterTag({
    Key key,
    @required int currentTitle,
    @required List<String> titles,
    @required this.onPressed,
  })  : _currentTitle = currentTitle,
        _titles = titles,
        super(key: key);

  final int _currentTitle;
  final List<String> _titles;
  final Function onPressed;

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: 80,
      child: InkWell(
        onTap: onPressed,
        child: Container(
          alignment: Alignment.center,
          padding: EdgeInsets.symmetric(vertical: 6, horizontal: 12),
          decoration: BoxDecoration(
            color: AppColors.GRAY_n141.withOpacity(.1),
            borderRadius: BorderRadius.circular(6),
          ),
          child: Row(
            children: [
              Text(
                _titles[_currentTitle],
                style: TextStyle(fontSize: 16, color: AppColors.GRAY_n141),
              ),
              SizedBox(width: 4),
              Icon(Icons.clear, size: 18,)
            ],
          ),
        ),
      ),
    );
  }
}