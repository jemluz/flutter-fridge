import 'package:flutter/material.dart';
import 'package:fridge/components/custom_list.dart';
import 'package:fridge/models/products.dart';
import 'package:provider/provider.dart';

import 'ranking_card.dart';

class TopFiveContent extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    final products = Provider.of<Products>(context);

    return SafeArea(
      child: Stack(
        alignment: Alignment.center,
        children: <Widget>[
          CustomList(
            child: ListView.builder(
              itemCount: products.usedRanking.length > 5 ? 5 : products.usedRanking.length,
              itemBuilder: (context, index) => RankingCard(
                index: index + 1,
                product: products.usedRanking[index],
                onPressed: () => print(products.usedRanking.length),
                size: size,
              ),
            ),
          ),
          Positioned(
            top: size.height * .05,
            child: Text(
              '- Mais consumidos - ',
              style: TextStyle(fontSize: 30),
            ),
          )
        ],
      ),
    );
  }
}
