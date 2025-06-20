part of 'bloc.dart';

abstract class StockOperationListingEvent extends Equatable {
  const StockOperationListingEvent();

  @override
  List<Object?> get props => [];
}

class SaveStockOperationList extends StockOperationListingEvent {
  const SaveStockOperationList({
    required this.operations,
    required this.database,
  });

  final List<StockOperation> operations;
  final Future<Database> database;

  @override
  List<Object?> get props => [
        operations,
        database,
      ];
}
