import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:invest_manager/adapters/stock_operations.dart';
import 'package:invest_manager/components/b3.dart';
import 'package:invest_manager/components/csv.dart';
import 'package:invest_manager/components/file_utils.dart';
import 'package:invest_manager/models/stock_operation.dart';

part 'events.dart';
part 'states.dart';

class ImportDataBloc extends Bloc<ImportDataEvent, ImportDataState> {
  ImportDataBloc() : super(const ImportDataRequestFile()) {
    on<SubmitCSVFile>((event, emit) async {
      emit(StockOperationCSVFileSubmitted(filePath: event.filePath));

      final csvContentText = readFileAsString(event.filePath);
      final csvMapList = csvToMapList(csvContentText);
      final List<StockOperation> operations = [];

      for (Map<String, String> csvMap in csvMapList) {
        final company = await companyByTicker(csvMap['ticker']!);
        operations.add(csvMap.toStockOperation(company));
      }

      emit(CSVFileStockOperationsImported(
        filePath: event.filePath,
        operations: operations,
      ));
    });

    on<StockOperationsSaved>((event, emit) async {
      emit(StockOperationsImportedSaved(
        filePath: event.filePath,
        operations: event.operations,
      ));
    });
  }
}
