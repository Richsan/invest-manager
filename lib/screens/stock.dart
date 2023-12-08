import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
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
      body: SingleChildScrollView(
        child: Column(
          children: [
            IntegerCounterField(
              initialValue: BigInt.from(100),
              stepValue: BigInt.from(100),
              allowNegative: false,
              allowZero: false,
            ),
            SizedBox(height: 16),
            TextFormField(
              decoration: const InputDecoration(
                labelText: 'OperationFee',
              ),
              inputFormatters: [FilteringTextInputFormatter.digitsOnly],
              keyboardType: TextInputType.number,
            ),
            TextFormField(
              decoration: const InputDecoration(
                labelText: 'Emoluments',
              ),
              inputFormatters: [FilteringTextInputFormatter.digitsOnly],
              keyboardType: TextInputType.number,
            ),
            TextFormField(
              decoration: const InputDecoration(
                labelText: 'Taxes',
              ),
              inputFormatters: [FilteringTextInputFormatter.digitsOnly],
              keyboardType: TextInputType.number,
            ),
            TextFormField(
              decoration: const InputDecoration(
                labelText: 'LiquidationFee',
              ),
              inputFormatters: [FilteringTextInputFormatter.digitsOnly],
              keyboardType: TextInputType.number,
            ),
            TextFormField(
              decoration: const InputDecoration(
                labelText: 'OtherFees',
              ),
              inputFormatters: [FilteringTextInputFormatter.digitsOnly],
              keyboardType: TextInputType.number,
            ),
          ],
        ),
      ),
    );
  }
}
