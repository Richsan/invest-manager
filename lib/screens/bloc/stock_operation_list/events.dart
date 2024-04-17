part of 'bloc.dart';

abstract class StockOperationListingEvent extends Equatable {
  const StockOperationListingEvent();

  @override
  List<Object?> get props => [];
}

class SaveStockOperationList extends StockOperationListingEvent {
  const SaveStockOperationList({
    required this.operations,
  });

  final List<StockOperation> operations;

  @override
  List<Object?> get props => [
        operations,
      ];
}
