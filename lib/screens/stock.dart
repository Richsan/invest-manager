import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:invest_manager/adapters/date.dart';
import 'package:invest_manager/adapters/entity.dart';
import 'package:invest_manager/adapters/number.dart';
import 'package:invest_manager/models/b3.dart';
import 'package:invest_manager/models/stock_operation.dart';
import 'package:invest_manager/screens/bloc/authentication/bloc.dart';
import 'package:invest_manager/screens/bloc/stock_operation/bloc.dart';
import 'package:invest_manager/widgets/input.dart';
import 'package:invest_manager/widgets/output.dart';

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
      operationType: OperationType.buy,
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
      operationType: OperationType.sell,
    );
  }
}

class StockOperationDetails extends StatelessWidget {
  const StockOperationDetails({
    super.key,
    required this.stockOperation,
  });

  final StockOperation stockOperation;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      margin: const EdgeInsets.only(
        top: 30,
      ),
      child: Column(
        crossAxisAlignment:
            CrossAxisAlignment.center, // Centraliza horizontalmente
        children: [
          Text(stockOperation.company.name),
          ValueDisplay(
            label: 'Operation Date',
            value: stockOperation.operationDate.toDateStr(),
          ),
          ValueDisplay(
            label: 'Liquidation Date',
            value: stockOperation.liquidationDate.toDateStr(),
          ),
          ValueDisplay(
            label: 'Unities',
            value: stockOperation.unities.toString(),
          ),
          ValueDisplay(
            label: 'Unity Value',
            value: stockOperation.unityValue.asCurrency(),
          ),
          ValueDisplay(
            label: 'Type',
            value: stockOperation.operationType.toEnumString(),
          ),
          ValueDisplay(
            label: 'Emoluments',
            value: stockOperation.emoluments.asCurrency(),
          ),
          ValueDisplay(
            label: 'Operation Fee',
            value: stockOperation.operationFee.asCurrency(),
          ),
          ValueDisplay(
            label: 'Liquidation Fee',
            value: stockOperation.liquidationFee.asCurrency(),
          ),
          ValueDisplay(
            label: 'Taxes',
            value: stockOperation.taxes.asCurrency(),
          ),
          ValueDisplay(
            label: 'Other Fees',
            value: stockOperation.otherFees.asCurrency(),
          ),
        ],
      ),
    );
  }
}

class StockOperationDetailsScreen extends StatelessWidget {
  const StockOperationDetailsScreen({
    super.key,
    required this.stockOperation,
  });

  final StockOperation stockOperation;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
            "${stockOperation.company.name} - ${stockOperation.operationType.toEnumString()}"),
      ),
      body: Column(
        children: [
          StockOperationDetails(
            stockOperation: stockOperation,
          ),
          ButtonBar(
            buttonPadding: EdgeInsets.all(30),
            alignment: MainAxisAlignment.center,
            children: [
              ElevatedButton.icon(
                icon: Icon(Icons.arrow_back),
                onPressed: () => Navigator.of(context).pop(),
                label: Text("Voltar", style: TextStyle(color: Colors.white)),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _StockOperationScreen extends StatelessWidget {
  _StockOperationScreen({
    required this.company,
    required this.title,
    required this.operationType,
  })  : ticker = DropDownTextField(
          label: 'Ticker',
          values: company.tickers.map((e) => e.b3code).toList(),
        ),
        unities = IntegerCounterField(
          initialValue: BigInt.from(100),
          stepValue: BigInt.from(100),
          allowNegative: false,
          allowZero: false,
          labelText: 'Unities',
        ),
        operationFee = CurrencyFormField(labelText: 'OperationFee'),
        emoluments = CurrencyFormField(labelText: 'Emoluments'),
        taxes = CurrencyFormField(labelText: 'Taxes'),
        liquidationFee = CurrencyFormField(labelText: 'LiquidationFee'),
        otherFees = CurrencyFormField(labelText: 'OtherFees'),
        unityValue = CurrencyFormField(labelText: 'unity value'),
        operationDate = DatePicker(
          labelText: 'Operation Date',
        ),
        liquidationDate = DatePicker(
          initialDate: DateTime.now().add(const Duration(days: 1)),
          labelText: 'Liquidation Date',
        );

  final Company company;
  final String title;
  final DropDownTextField ticker;
  final IntegerCounterField unities;
  final CurrencyFormField operationFee;
  final CurrencyFormField emoluments;
  final CurrencyFormField taxes;
  final CurrencyFormField liquidationFee;
  final CurrencyFormField otherFees;
  final CurrencyFormField unityValue;
  final DatePicker operationDate;
  final DatePicker liquidationDate;
  final OperationType operationType;

  Widget buildBody(BuildContext context, bool isLoading) =>
      SingleChildScrollView(
        child: Column(
          children: [
            unities,
            ticker,
            SizedBox(height: 16),
            operationFee,
            emoluments,
            taxes,
            liquidationFee,
            otherFees,
            unityValue,
            operationDate,
            liquidationDate,
            SizedBox(height: 20),
            SubmitButton(
                text: 'Save',
                isLoading: isLoading,
                onSubmit: (() =>
                    BlocProvider.of<SaveStockOperationScreenBloc>(context).add(
                      SaveStockOperationEvent(
                        operation: StockOperation(
                          ticker: ticker.currentValue,
                          operationType: operationType,
                          company: company,
                          emoluments: emoluments.currentValue!,
                          liquidationDate: liquidationDate.currentValue!,
                          liquidationFee: liquidationFee.currentValue!,
                          operationDate: operationDate.currentValue!,
                          operationFee: operationFee.currentValue!,
                          otherFees: otherFees.currentValue!,
                          taxes: taxes.currentValue!,
                          unityValue: unityValue.currentValue!,
                          unities: unities.currentValue,
                        ),
                        database: BlocProvider.of<AuthenticationBloc>(context)
                            .getUserDatabase(),
                      ),
                    ))),
          ],
        ),
      );

  Widget buildScreen(BuildContext context) {
    return BlocBuilder<SaveStockOperationScreenBloc, StockOperationScreenState>(
      builder: (context, state) {
        if (state is InitialStockOperationScreenState) {
          return buildBody(context, false);
        }

        if (state is SavingStockOperationScreenState) {
          return buildBody(context, true);
        }

        if (state is SavedStockOperationScreenState) {
          return StockOperationDetails(
            stockOperation: state.operation,
          );
        }

        return const Text('error');
      },
    );
  }

  Widget buildStateScreen(BuildContext context) {
    return BlocProvider(
      create: (context) => SaveStockOperationScreenBloc(company: company),
      child: buildScreen(context),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: Text(title),
      ),
      body: buildStateScreen(context),
    );
  }
}
