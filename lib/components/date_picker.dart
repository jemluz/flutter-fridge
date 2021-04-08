import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class DatePicker extends StatelessWidget {
  final DateTime selectedDate;
  final Function(DateTime) onDateChange;

  DatePicker({
    this.selectedDate,
    this.onDateChange,
  });

  _showDatePicker(BuildContext context) {
    showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2019),
      lastDate: DateTime.now(),
    ).then((pickedDate) {
      if (pickedDate == null) {
        return;
      }

      onDateChange(pickedDate);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(top: 24),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text(
            selectedDate == null
                ? 'Nenhuma data selecionada!'
                : DateFormat('dd/MM/y').format(selectedDate),
          ),
          TextButton(
            // textColor: Theme.of(context).primaryColor,
            child: Text(
              'Escolha uma data',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            onPressed: () => _showDatePicker(context),
          )
        ],
      ),
    );
  }
}
