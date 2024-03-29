import 'package:flutter/material.dart';
import 'package:invest_manager/models/stock_operation.dart';

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
                    title: Text('Company: ${operation.company.name}'),
                    subtitle: Text(
                      'Operation Date: ${operation.operationDate.toString()}\n'
                      'Operation Type: ${operation.operationType == OperationType.buy ? 'Buy' : 'Sell'}\n'
                      'Unity Value: ${operation.unityValue}\n'
                      'Operation Unities: ${operation.unities}\n'
                      'Taxes: ${operation.taxes}\n'
                      'Operation Fee: ${operation.operationFee}\n'
                      'Emoluments: ${operation.emoluments}\n'
                      'Liquidation Fee: ${operation.liquidationFee}\n'
                      'Other Fees: ${operation.otherFees}',
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
