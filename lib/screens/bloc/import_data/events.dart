part of 'bloc.dart';

abstract class ImportDataEvent extends Equatable {
  const ImportDataEvent();

  @override
  List<Object> get props => [];
}

class RequestFileSubmission extends ImportDataEvent {
  const RequestFileSubmission();
}

class SubmitCSVFile extends ImportDataEvent {
  const SubmitCSVFile({
    required this.filePath,
  });

  final String filePath;
}

class StockOperationsSaved extends ImportDataEvent {
  const StockOperationsSaved({
    required this.filePath,
    required this.operations,
  });

  final String filePath;
  final List<StockOperation> operations;
}
