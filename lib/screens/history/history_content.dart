import 'package:flutter/material.dart';
import 'package:fridge/components/custom_transaction_list.dart';
import 'package:fridge/models/product.dart';
import 'package:fridge/models/products.dart';
import 'package:fridge/models/transaction.dart';
import 'package:fridge/models/transactions.dart';
import 'package:fridge/components/transaction_form.dart';
import 'package:provider/provider.dart';

import '../../enums.dart';
import 'action_bar.dart';
import 'filter_tag.dart';
import 'transaction_card.dart';

class HistoryContent extends StatefulWidget {
  @override
  _HistoryContentState createState() => _HistoryContentState();
}

enum FilterState { withoutFilter, consumeFilter, additiveFilter }

class _HistoryContentState extends State<HistoryContent> {
  FilterState _currentFilter = FilterState.withoutFilter;
  int _currentTitle = 0;

  final List<String> _titles = ['', 'Apenas consumo', 'Apenas adições'];

  _setFilter(int index) {
    setState(() {
      _currentTitle = index;
      print(_titles[_currentTitle]);
    });
  }

  _filterByUsedTransactions() {
    setState(() {
      _currentFilter = FilterState.consumeFilter;
      _setFilter(1);
    });
  }

  _filterByAdditiveTransactions() {
    setState(() {
      _currentFilter = FilterState.additiveFilter;
      _setFilter(2);
    });
  }

  _clearFilters() {
    setState(() {
      _currentFilter = FilterState.withoutFilter;
      _setFilter(0);
    });
  }

  _showTransactionDialog(BuildContext context, SubmitType type,
      String dialogTitle, Transaction transaction,
      [Product productParent]) {
    showDialog(
        context: context,
        barrierDismissible: true,
        builder: (_) {
          return TransactionForm(
            submitType: type,
            receivedTransaction: transaction,
            productParent: productParent,
            dialogTitle: dialogTitle,
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    final transactions = Provider.of<Transactions>(context);
    final products = Provider.of<Products>(context);

    int getDisplayedLenght() {
      if (_currentFilter == FilterState.withoutFilter) {
        return transactions.orderByDate.length;
      }

      if (_currentFilter == FilterState.consumeFilter) {
        return transactions.onlyConsume.length;
      }

      if (_currentFilter == FilterState.additiveFilter) {
        return transactions.onlyAdditive.length;
      }

      return null;
    }

    List<Transaction> getDisplayedList() {
      if (_currentFilter == FilterState.withoutFilter) {
        return transactions.orderByDate;
      }

      if (_currentFilter == FilterState.consumeFilter) {
        return transactions.onlyConsume;
      }

      if (_currentFilter == FilterState.additiveFilter) {
        return transactions.onlyAdditive;
      }

      return null;
    }

    return SafeArea(
      child: Stack(
        alignment: Alignment.center,
        children: <Widget>[
          CustomTransactionList(
            isTagsDisplayed:
                _currentFilter == FilterState.withoutFilter ? true : false,
            child: ListView.builder(
              itemCount: getDisplayedLenght(),
              itemBuilder: (context, index) => TransactionCard(
                transaction: getDisplayedList()[index],
                onPressed: () => 
                _showTransactionDialog(
                  context,
                  SubmitType.update,
                  'Editar transação',
                  getDisplayedList()[index],
                  products.items[index],
                ),
              ),
            ),
          ),
          ActionBar(
            text: 'Nova transação',
            onPressed: () {},
            onPressedMinus: () => _filterByUsedTransactions(),
            onPressedPlus: () => _filterByAdditiveTransactions(),
          ),
          _currentTitle == 1 || _currentTitle == 2
              ? FilterTag(
                  currentTitle: _currentTitle,
                  titles: _titles,
                  onPressed: () => _clearFilters(),
                )
              : SizedBox(width: 2)
        ],
      ),
    );
  }
}
