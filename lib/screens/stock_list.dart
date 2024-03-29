import 'package:flutter/material.dart';
import 'package:invest_manager/adapters/date.dart';
import 'package:invest_manager/adapters/number.dart';
import 'package:invest_manager/models/stock_operation.dart';
import 'package:invest_manager/screens/stock.dart';

class StockOperationListScreen extends StatelessWidget {
  final List<StockOperation> stockOperations;

  const StockOperationListScreen({super.key, required this.stockOperations});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Stock Operation List'),
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              scrollDirection: Axis.vertical,
              itemCount: stockOperations.length,
              itemBuilder: (context, index) {
                final operation = stockOperations[index];
                return Card(
                  margin: EdgeInsets.only(top: 15),
                  child: ListTile(
                    leading: operation.operationType == OperationType.sell
                        ? Icon(
                            Icons.sell,
                            color: Colors.red,
                          )
                        : Icon(
                            Icons.shopping_cart,
                            color: Colors.lightGreen,
                          ),
                    title: Text(
                        'Company: ${operation.company.name} - ${operation.ticker}'),
                    subtitle: Text(
                        'Unity Value: ${operation.unityValue.asCurrency()}\n'
                        'Operation Unities: ${operation.unities}\n'
                        'Operation Date: ${operation.operationDate.toDateStr()}\n'),
                    onTap: () => Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => StockOperationDetailsScreen(
                            stockOperation: operation),
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
