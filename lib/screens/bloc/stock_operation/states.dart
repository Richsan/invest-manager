part of 'bloc.dart';

abstract class StockOperationScreenState extends Equatable {
  const StockOperationScreenState();

  @override
  List<Object> get props => [];
}

class InitialStockOperationScreenState extends StockOperationScreenState {
  const InitialStockOperationScreenState({
    required this.company,
  }) : super();

  final Company company;

  @override
  List<Object> get props => [company];
}

class SavingStockOperationScreenState extends StockOperationScreenState {
  const SavingStockOperationScreenState({required this.operation}) : super();

  final StockOperation operation;

  @override
  List<Object> get props => [operation];
}

class SavedStockOperationScreenState extends StockOperationScreenState {
  const SavedStockOperationScreenState({
    required this.operation,
  }) : super();

  final StockOperation operation;

  @override
  List<Object> get props => [operation];
}
