import 'package:flutter/material.dart';
import 'package:invest_manager/models/b3.dart';
import 'package:invest_manager/widgets/input.dart';

class StockBuyScreen extends StatelessWidget {
  const StockBuyScreen({
    super.key,
    required this.company,
  });

  final Company company;

  @override
  Widget build(BuildContext context) {
    return _StockOperationScreen(
      company: company,
      title: "Buy a Company",
    );
  }
}

class StockSellScreen extends StatelessWidget {
  const StockSellScreen({
    super.key,
    required this.company,
  });

  final Company company;

  @override
  Widget build(BuildContext context) {
    return _StockOperationScreen(
      company: company,
      title: "Sell a Company",
    );
  }
}

class _StockOperationScreen extends StatelessWidget {
  const _StockOperationScreen({
    super.key,
    required this.company,
    required this.title,
  });

  final Company company;
  final String title;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: Text(title),
      ),
      body: Container(
        width: MediaQuery.of(context).size.width,
        child: Column(
          children: [CounterField()],
        ),
      ),
    );
  }
}
