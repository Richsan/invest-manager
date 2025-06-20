import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:invest_manager/models/b3.dart';
import 'package:invest_manager/models/stock_operation.dart';
import 'package:invest_manager/repository/stock_operation.dart';
import 'package:sqflite_sqlcipher/sqflite.dart';

part 'events.dart';
part 'states.dart';

class SaveStockOperationScreenBloc
    extends Bloc<SaveStockOperationEvent, StockOperationScreenState> {
  SaveStockOperationScreenBloc({
    required Company company,
  }) : super(InitialStockOperationScreenState(company: company)) {
    on<SaveStockOperationEvent>((event, emit) async {
      emit(SavingStockOperationScreenState(operation: event.operation));

      // Save to database
      await save(event.database, event.operation);

      emit(SavedStockOperationScreenState(
        operation: event.operation,
      ));
    });
  }
}
