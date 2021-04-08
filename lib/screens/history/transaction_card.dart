import 'package:intl/intl.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fridge/models/transaction.dart';

import '../../themes.dart';

class TransactionCard extends StatelessWidget {
  const TransactionCard({
    Key key,
    this.onPressed,
    @required this.transaction,
  }) : super(key: key);

  final GestureTapCallback onPressed;
  final Transaction transaction;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressed,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 18),
        margin: EdgeInsets.only(left: 20, right: 20),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                buildDateTime(DateTime.parse(transaction.date)),
                builInfo(context, transaction.productName, transaction.amount, transaction.isAdditive),
              ],
            ),
            SizedBox(height: 20),
            Divider(
              color: AppColors.GRAY_n141.withOpacity(.4), 
              height: 4,
            ),
            SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  Column buildDateTime(DateTime date) {
    return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Row(
                  children: [
                    SvgPicture.asset(
                      'assets/icons/clock.svg',
                      height: 14,
                      color: AppColors.GRAY_n141.withOpacity(.6),
                    ),
                    SizedBox(width: 8),
                    Text(
                      DateFormat('HH : mm').format(date),
                      style: TextStyle(
                        fontSize: 16,
                        color: AppColors.GRAY_n141.withOpacity(.8),
                      ),
                    )
                  ],
                ),
                SizedBox(height: 4),
                Row(
                  children: [
                    SvgPicture.asset(
                      'assets/icons/calendar.svg',
                      height: 14,
                      color: AppColors.GRAY_n141.withOpacity(.6),
                    ),
                    SizedBox(width: 8),
                    Text(
                      DateFormat('d / MM / y').format(date),
                      style: TextStyle(
                        fontSize: 16,
                        color: AppColors.GRAY_n141.withOpacity(.8),
                      ),
                    )
                  ],
                )
              ],
            );
  }

  Column builInfo(BuildContext context, String name, int amount, bool isAdditive) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.only(right: 12),
          child: Text(
            name,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 20,
            ),
          ),
        ),
        SizedBox(height: 4),
        Container(
          padding: EdgeInsets.symmetric(vertical: 4, horizontal: 12),
          decoration: BoxDecoration(
            color: isAdditive ? Theme.of(context).colorScheme.primary.withOpacity(.05) : Theme.of(context).colorScheme.error.withOpacity(.05),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Row(
            children: [
              isAdditive ? SvgPicture.asset('assets/icons/additive.svg', color: Theme.of(context).primaryColor,) : SvgPicture.asset('assets/icons/consume.svg', ),
              SizedBox(width: 8),
              Text(
                '$amount unidades',
                style: TextStyle(
                    color: isAdditive ? Theme.of(context).colorScheme.primary.withOpacity(.8) : Theme.of(context).colorScheme.error.withOpacity(.8), fontSize: 14),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
