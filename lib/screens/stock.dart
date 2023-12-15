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
  _StockOperationScreen({
    required this.company,
    required this.title,
  })  : unities = IntegerCounterField(
          initialValue: BigInt.from(100),
          stepValue: BigInt.from(100),
          allowNegative: false,
          allowZero: false,
          labelText: 'Unities',
        ),
        operationFee = NumberFormField(labelText: 'OperationFee'),
        emoluments = NumberFormField(labelText: 'Emoluments'),
        taxes = NumberFormField(labelText: 'Taxes'),
        liquidationFee = NumberFormField(labelText: 'LiquidationFee'),
        otherFees = NumberFormField(labelText: 'OtherFees');

  final Company company;
  final String title;
  final IntegerCounterField unities;
  final NumberFormField operationFee;
  final NumberFormField emoluments;
  final NumberFormField taxes;
  final NumberFormField liquidationFee;
  final NumberFormField otherFees;

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
            unities,
            SizedBox(height: 16),
            operationFee,
            emoluments,
            taxes,
            liquidationFee,
            otherFees,
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: (() => print({
                    'OperationFee': operationFee.currentValue,
                    'counter': unities.currentValue,
                    'emoluments': emoluments.currentValue,
                    'taxes': taxes.currentValue,
                    'liquidationFee': liquidationFee.currentValue,
                    'otherFees': otherFees.currentValue,
                  })),
              style: ElevatedButton.styleFrom(),
              child: Text('Salvar'),
            ),
          ],
        ),
      ),
    );
  }
}
