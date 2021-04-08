import 'package:flutter/material.dart';
import 'package:fridge/models/transactions.dart';
import 'package:provider/provider.dart';

import '../themes.dart';

class CustomTransactionList extends StatefulWidget {
  CustomTransactionList({
    Key key,
    @required this.child,
    @required this.isTagsDisplayed,
  }) : super(key: key);

  Widget child;
  bool isTagsDisplayed = false;

  @override
  _CustomTransactionListState createState() => _CustomTransactionListState();
}

class _CustomTransactionListState extends State<CustomTransactionList> {
  bool isLoading = true;

  Future<void> _refreshTransactions(BuildContext context) async {
    return Provider.of<Transactions>(context, listen: false).loadTransactions();
  }

  @override
  void initState() {
    super.initState();
    Provider.of<Transactions>(context, listen: false).loadTransactions().then((_) {
      setState(() => isLoading = false);
    });
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;

    return Container(
      height: size.height * .65,
      width: size.width,
      margin: EdgeInsets.only(top: 20),
      padding: EdgeInsets.symmetric(horizontal: size.width * .05),
      decoration: backgroundDecoration(),
      child: SingleChildScrollView(
        child: RefreshIndicator(
          onRefresh: () => _refreshTransactions(context),
          backgroundColor: Theme.of(context).primaryColor,
          child: Container(
            alignment: Alignment.bottomCenter,
            height: size.height * (widget.isTagsDisplayed ? .6 : .5),
            margin: EdgeInsets.only(top: widget.isTagsDisplayed ? 70 : 110),
            child: widget.child,
          ),
        ),
      ),
    );
  }

  BoxDecoration backgroundDecoration() {
    return BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.only(
        topLeft: Radius.circular(46),
        topRight: Radius.circular(46),
      ),
      boxShadow: <BoxShadow>[
        BoxShadow(
          offset: Offset(0, -10),
          blurRadius: 10,
          color: AppColors.BLACK.withOpacity(.05),
        )
      ],
    );
  }
}
