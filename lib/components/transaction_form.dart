import 'package:flutter/material.dart';
import 'package:fridge/components/date_picker.dart';
import 'package:fridge/components/error_dialog.dart';
import 'package:fridge/components/text_input.dart';
import 'package:fridge/models/product.dart';
import 'package:fridge/models/transaction.dart';
import 'package:fridge/models/transactions.dart';
import 'package:fridge/screens/history/filter_button.dart';
import 'package:provider/provider.dart';

import '../enums.dart';
import '../themes.dart';
import '../validations.dart';

class TransactionForm extends StatefulWidget {
  SubmitType submitType;
  Transaction receivedTransaction;
  Product productParent;
  String dialogTitle;

  TransactionForm({
    @required this.submitType,
    @required this.dialogTitle,
    this.receivedTransaction,
    this.productParent,
  });

  @override
  _TransactionFormState createState() => _TransactionFormState();
}

class _TransactionFormState extends State<TransactionForm> {
  TextEditingController _productNameCtrl;
  TextEditingController _amountCtrl;

  DateTime _date = DateTime.now();
  bool _isAdditive;

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
    final productParent = widget.productParent;
    final transaction = widget.receivedTransaction;

    if(widget.receivedTransaction == null) {
      _isAdditive = true;
    } else {
      _isAdditive = widget.receivedTransaction.isAdditive;
    }

    // to add transaction modal (receive a product)
    if (__transactionFormData.isEmpty && productParent != null ||
        widget.submitType == SubmitType.save) {
      _productNameCtrl = TextEditingController(text: '${productParent.name}');
      _amountCtrl = TextEditingController(text: '${productParent.amount}');

      __transactionFormData['productName'] = productParent.name;
      __transactionFormData['amount'] = productParent.amount;
      __transactionFormData['date'] = _date;
      __transactionFormData['isAdditive'] = _isAdditive;
    }

    // to update trasaction modal (receive a transaction)
    if (__transactionFormData.isEmpty && transaction != null ||
        widget.submitType == SubmitType.update) {
      __transactionFormData['id'] = transaction.id;
      __transactionFormData['productName'] = transaction.productName;
      __transactionFormData['amount'] = transaction.amount;
      __transactionFormData['isAdditive'] = transaction.isAdditive;
      __transactionFormData['date'] = transaction.date;

      _productNameCtrl =
          TextEditingController(text: '${transaction.productName}');
      _amountCtrl = TextEditingController(text: '${transaction.amount}');
    }
  }

  _setTransactionType(bool value) {
    setState(() {
      _isAdditive = value;
      __transactionFormData['isAdditive'] = _isAdditive;

  
    });
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
      isAdditive: __transactionFormData['isAdditive'],
    );

    setState(() => _isLoading = true);

    try {
      if (widget.submitType == SubmitType.save && newTransaction.id == null) {
        await transactions.saveTransaction(newTransaction);
      } else {
        await transactions.updateTransaction(
            __transactionFormData['id'], newTransaction);
      }

      Navigator.of(context).pop();
    } catch (error) {
      await showDialog<Null>(
        context: context,
        builder: (ctx) => ErrorDialog(
          context: context,
          message: error,
        ),
      );
    } finally {
      setState(() => _isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final transactions = Provider.of<Transactions>(context, listen: false);
    
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
                                onPressed: () => _setTransactionType(true),
                                iconColor:_isAdditive
                                    ? Theme.of(context).primaryColor
                                    : AppColors.GRAY_n135,
                                bgColor: _isAdditive
                                    ? Theme.of(context).accentColor
                                    : AppColors.GRAY_n236,
                              ),
                              SizedBox(width: 18),
                              FilterButton(
                                icon: 'assets/icons/consume.svg',
                                onPressed: () => _setTransactionType(false),
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
                      SizedBox(height: 16),
                      widget.submitType == SubmitType.save ? SizedBox() : Material(
                        color: AppColors.RED_n230.withOpacity(.1),
                        child: InkWell(
                          onTap: () {
                            showDialog(
                              context: context,
                              builder: (ctx) => AlertDialog(
                                title: Text('Excluir produto'),
                                content: Text(
                                    'Tem certeza que quer excluir esta transação?'),
                                actions: [
                                  TextButton(
                                    child: Text('Não'),
                                    onPressed: () =>
                                        Navigator.of(context).pop(),
                                  ),
                                  TextButton(
                                    child: Text('Sim'),
                                    onPressed: () =>
                                        Navigator.of(context).pop(true),
                                  )
                                ],
                              ),
                            ).then((value) {
                              if (value) {
                                try {
                                  transactions.deleteTransaction(widget.receivedTransaction.id);
                                  Navigator.of(context).pop();
                                } catch (error) {
                                  print(error.toString());
                                }
                              }
                            });
                          },
                          highlightColor: AppColors.RED_n230.withOpacity(.1),
                          child: Container(
                            padding: const EdgeInsets.symmetric(vertical: 12),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                Icon(Icons.delete, color: AppColors.RED_n230),
                                SizedBox(width: 12),
                                Text(
                                  'Excluir transação',
                                  style: TextStyle(
                                      fontSize: 18, color: AppColors.RED_n230),
                                ),
                              ],
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
          );
  }
}
