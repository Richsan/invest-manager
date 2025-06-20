import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:invest_manager/models/stock_operation.dart';
import 'package:invest_manager/repository/stock_operation.dart';
import 'package:sqflite_sqlcipher/sqflite.dart';

part 'events.dart';
part 'states.dart';

class StockOperationListingBloc
    extends Bloc<StockOperationListingEvent, StockOperationListingState> {
  StockOperationListingBloc({
    required List<StockOperation> operations,
    required this.onSaved,
  }) : super(ListState(
          operations: operations,
        )) {
    on<SaveStockOperationList>((event, emit) async {
      emit(SavingListState(
        operations: event.operations,
      ));

      await saveAll(event.database, event.operations);

      emit(SavedListState(
        operations: event.operations,
      ));

      if (onSaved != null) {
        onSaved!();
      }
    });
  }

  final VoidCallback onSaved;
}
