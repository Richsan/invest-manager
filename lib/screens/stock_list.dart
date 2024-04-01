import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:invest_manager/adapters/date.dart';
import 'package:invest_manager/adapters/number.dart';
import 'package:invest_manager/models/stock_operation.dart';
import 'package:invest_manager/screens/bloc/screen_loader/bloc.dart';
import 'package:invest_manager/screens/stock.dart';

class _StockOperationList extends StatelessWidget {
  const _StockOperationList({
    super.key,
    required this.stockOperations,
  });

  final List<StockOperation> stockOperations;

  @override
  Widget build(BuildContext context) {
    return Column(
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
                      ? const Icon(
                          Icons.sell,
                          color: Colors.red,
                        )
                      : const Icon(
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
    );
  }
}

class StockOperationListScreen extends StatelessWidget {
  const StockOperationListScreen({
    super.key,
    required this.stockOperationsFuture,
  });

  final Future<List<StockOperation>> stockOperationsFuture;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Stock Operation List'),
      ),
      body: BlocProvider(
        create: (context) => LoaderScreenBloc(data: stockOperationsFuture),
        child: BlocBuilder<LoaderScreenBloc, LoaderScreenState>(
          builder: (context, state) {
            if (state is InitialLoaderScreenState) {
              BlocProvider.of<LoaderScreenBloc>(context).add(
                LoadScreenEvent(data: state.data),
              );
              return const Text('loading...');
            }

            if (state is LoadingState) {
              return const Text('loading...');
            }

            if (state is LoadedState) {
              return _StockOperationList(stockOperations: state.data);
            }

            return const Text('error');
          },
        ),
      ),
    );
  }
}
