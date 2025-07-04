part of 'bloc.dart';

abstract class SaveStockOperationScreenEvent extends Equatable {
  const SaveStockOperationScreenEvent({
    required this.operation,
  });

  final StockOperation operation;
  @override
  List<Object?> get props => [
        operation,
      ];
}

class SaveStockOperationEvent extends SaveStockOperationScreenEvent {
  const SaveStockOperationEvent({
    required StockOperation operation,
    required this.database,
  }) : super(operation: operation);

  final Future<Database> database;
}
