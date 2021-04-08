import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:fridge/components/date_picker.dart';
import 'package:fridge/components/error_dialog.dart';
import 'package:fridge/components/text_input.dart';
import 'package:fridge/models/product.dart';
import 'package:fridge/models/transaction.dart';
import 'package:fridge/models/transactions.dart';
import 'package:fridge/screens/history/filter_button.dart';
import 'package:provider/provider.dart';

import '../../enums.dart';
import '../../themes.dart';
import '../../validations.dart';

class TransactionForm extends StatefulWidget {
  SubmitType submitType;
  // Transaction receivedTransaction;
  Product productParent;
  String dialogTitle;

  TransactionForm(
    this.submitType,
    // this.receivedTransaction,
    this.productParent,
    this.dialogTitle,
  );

  @override
  _TransactionFormState createState() => _TransactionFormState();
}

class _TransactionFormState extends State<TransactionForm> {
  TextEditingController _productNameCtrl;
  TextEditingController _amountCtrl;

  DateTime _date = DateTime.now();
  bool _isAdditive = true;

  final _addTransactionForm = GlobalKey<FormState>();
  final __transactionFormData = Map<String, Object>();

  Color getColor(Set<MaterialState> states) {
    const Set<MaterialState> interactiveStates = <MaterialState>{
      MaterialState.pressed,
      MaterialState.hovered,
      MaterialState.focused,
    };

    if (states.any(interactiveStates.contains)) {
      return Theme.of(context).errorColor.withOpacity(.1);
    }

    return Colors.transparent;
  }

  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    // final transaction = widget.receivedTransaction;

    // if (__transactionFormData.isEmpty && transaction != null) {
    //   __transactionFormData['id'] = transaction.id;
    //   __transactionFormData['productName'] = transaction.productName;
    //   __transactionFormData['amount'] = transaction.amount;
    //   __transactionFormData['isAdditive'] = transaction.isAdditive;

    //   _productNameCtrl =
    //       TextEditingController(text: '${transaction.productName}');
    //   _amountCtrl = TextEditingController(text: '${transaction.amount}');
    //   _dateCtrl = transaction.date;
    //   _isAdditiveCtrl = transaction.isAdditive;
    // } else {
    //   _dateCtrl = DateTime.now();
    //   _isAdditiveCtrl = true;
    // }

    final productParent = widget.productParent;

    if (__transactionFormData.isEmpty && productParent != null) {
      _productNameCtrl = TextEditingController(text: '${productParent.name}');
      _amountCtrl = TextEditingController(text: '${productParent.amount}');

      __transactionFormData['productName'] = productParent.name;
      __transactionFormData['amount'] = productParent.amount;
      __transactionFormData['date'] = _date;
      __transactionFormData['isAdditive'] = _isAdditive;
    }
  }

  Future<void> _submitForm() async {
    final transactions = Provider.of<Transactions>(context, listen: false);

    Validation.validateForm(_addTransactionForm);
    _addTransactionForm.currentState.save();

    final newTransaction = Transaction(
      id: __transactionFormData['id'],
      productName: __transactionFormData['productName'],
      amount: __transactionFormData['amount'],
      date: __transactionFormData['date'].toString(),
      isAdditive:  __transactionFormData['isAdditive'],
    );

    print(__transactionFormData);

    await transactions.saveTransaction(newTransaction);
    Navigator.of(context).pop();

    // print(newTransaction.id);
    // print(newTransaction.productName);
    // print(newTransaction.amount);
    // print(newTransaction.date);
    // print(newTransaction.isAdditive);

    // setState(() => _isLoading = true);

    //   try {
    //     if (widget.submitType == SubmitType.save && newTransaction.id == null) {
    //       await transactions.saveTransaction(newTransaction);
    //     } else {
    //       await transactions.updateTransaction(
    //           __transactionFormData['id'], newTransaction);
    //     }

    //     Navigator.of(context).pop();
    //   } catch (error) {
    //     await showDialog<Null>(
    //       context: context,
    //       builder: (ctx) => ErrorDialog(
    //         context: context,
    //         message: error,
    //       ),
    //     );
    //   } finally {
    //     setState(() => _isLoading = false);
    //   }
  }

  @override
  Widget build(BuildContext context) {
    return _isLoading
        ? Center(
            child: CircularProgressIndicator(),
          )
        : SingleChildScrollView(
            child: AlertDialog(
              title: Text(widget.dialogTitle),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15),
              ),
              actions: [
                TextButton(
                  onPressed: () => Navigator.of(context).pop(),
                  style: ButtonStyle(
                    foregroundColor:
                        MaterialStateProperty.resolveWith(getColor),
                  ),
                  child: Text(
                    'Cancelar',
                    style: TextStyle(color: Theme.of(context).errorColor),
                  ),
                ),
                TextButton(
                    onPressed: () => _submitForm(), child: Text('Confirmar')),
              ],
              content: SingleChildScrollView(
                child: Form(
                  key: _addTransactionForm,
                  child: Column(
                    children: <Widget>[
                      TextInput(
                        label: "Nome do Item",
                        ctrl: _productNameCtrl,
                        onSaved: (value) =>
                            __transactionFormData['productName'] = value,
                        onValidation: (value) =>
                            Validation.nameValidation(value),
                      ),
                      SizedBox(height: 16),
                      TextInput(
                        label: "Quantidade",
                        ctrl: _amountCtrl,
                        onSaved: (value) =>
                            __transactionFormData['amount'] = int.parse(value),
                        onValidation: (value) =>
                            Validation.amountValidation(value),
                        keyboardType: TextInputType.number,
                      ),
                      SizedBox(height: 24),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            _isAdditive ? 'Adição' : '',
                            style: TextStyle(color: AppColors.GRAY_n135),
                          ),
                          SizedBox(width: 18),
                          Row(
                            children: <Widget>[
                              FilterButton(
                                icon: 'assets/icons/additive.svg',
                                onPressed: () =>
                                    __transactionFormData['isAdditive'] = true,
                                iconColor: _isAdditive
                                    ? Theme.of(context).primaryColor
                                    : AppColors.GRAY_n135,
                                bgColor: _isAdditive
                                    ? Theme.of(context).accentColor
                                    : AppColors.GRAY_n236,
                              ),
                              SizedBox(width: 18),
                              FilterButton(
                                icon: 'assets/icons/consume.svg',
                                onPressed: () =>
                                    __transactionFormData['isAdditive'] = false,
                                iconColor: _isAdditive
                                    ? AppColors.GRAY_n135
                                    : Theme.of(context).errorColor,
                                bgColor: _isAdditive
                                    ? AppColors.GRAY_n236
                                    : AppColors.RED_n254,
                              ),
                            ],
                          ),
                          SizedBox(width: 18),
                          Text(
                            _isAdditive ? '' : 'Consumo',
                            style: TextStyle(color: AppColors.GRAY_n135),
                          ),
                        ],
                      ),
                      DatePicker(
                        selectedDate: DateTime.parse(
                            __transactionFormData['date'].toString()),
                        onDateChange: (value) =>
                            __transactionFormData['date'] = value,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
  }
}
