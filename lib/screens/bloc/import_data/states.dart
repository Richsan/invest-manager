part of 'bloc.dart';

abstract class ImportDataState extends Equatable {
  const ImportDataState();

  @override
  List<Object> get props => [];
}

class ImportDataRequestFile extends ImportDataState {
  const ImportDataRequestFile();
}

class StockOperationCSVFileSubmitted extends ImportDataState {
  const StockOperationCSVFileSubmitted({
    required this.filePath,
  });

  final String filePath;

  @override
  List<Object> get props => [
        filePath,
      ];
}

class CSVFileStockOperationsImported extends ImportDataState {
  const CSVFileStockOperationsImported({
    required this.filePath,
    required this.operations,
  });

  final String filePath;
  final List<StockOperation> operations;

  @override
  List<Object> get props => [
        filePath,
        operations,
      ];
}

class StockOperationsImportedSaved extends ImportDataState {
  const StockOperationsImportedSaved({
    required this.filePath,
    required this.operations,
  });

  final String filePath;
  final List<StockOperation> operations;

  @override
  List<Object> get props => [
        filePath,
        operations,
      ];
}
