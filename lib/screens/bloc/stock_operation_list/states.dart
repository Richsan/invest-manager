part of 'bloc.dart';

abstract class StockOperationListingState extends Equatable {
  const StockOperationListingState();

  @override
  List<Object> get props => [];
}

class ListState extends StockOperationListingState {
  const ListState({
    required this.operations,
  });

  final List<StockOperation> operations;

  @override
  List<Object> get props => [
        operations,
      ];
}

class SavingListState extends StockOperationListingState {
  const SavingListState({
    required this.operations,
  });

  final List<StockOperation> operations;

  @override
  List<Object> get props => [
        operations,
      ];
}

class SavedListState extends StockOperationListingState {
  const SavedListState({
    required this.operations,
  });

  final List<StockOperation> operations;

  @override
  List<Object> get props => [
        operations,
      ];
}
