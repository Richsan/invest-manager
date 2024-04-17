import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:invest_manager/models/stock_operation.dart';
import 'package:invest_manager/screens/bloc/import_data/bloc.dart';
import 'package:invest_manager/screens/stock_list.dart';
import 'package:invest_manager/widgets/input.dart';

class ImportDataScreen extends StatelessWidget {
  const ImportDataScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ImportDataBloc(),
      child: BlocBuilder<ImportDataBloc, ImportDataState>(
        builder: (context, state) {
          if (state is ImportDataRequestFile) {
            return buildStateless(context);
          }

          if (state is StockOperationCSVFileSubmitted) {
            return buildStateless(context, importButtonDisabled: true);
          }

          if (state is CSVFileStockOperationsImported) {
            return buildStateless(
              context,
              importButtonDisabled: true,
              operations: state.operations,
              onSaved: () => BlocProvider.of<ImportDataBloc>(context)
                  .add(StockOperationsSaved(
                filePath: state.filePath,
                operations: state.operations,
              )),
            );
          }

          if (state is StockOperationsImportedSaved) {
            return buildStateless(context, saved: true);
          }

          return const Text('error');
        },
      ),
    );
  }

  Widget buildStateless(
    BuildContext context, {
    bool importButtonDisabled = false,
    List<StockOperation>? operations,
    VoidCallback? onSaved,
    bool saved = false,
  }) {
    return Scaffold(
      appBar: AppBar(title: const Text('Import Data')),
      body: Column(
        children: [
          FilePickerButton(
            label: 'import csv',
            disabled: importButtonDisabled,
            onFilePicked: (pathChosen) =>
                BlocProvider.of<ImportDataBloc>(context)
                    .add(SubmitCSVFile(filePath: pathChosen)),
          ),
          const SizedBox(
            height: 10,
          ),
          saved
              ? const Text('Stock operations saved successfully!')
              : const SizedBox(
                  height: 0,
                ),
          operations != null
              ? StockOperationListToSave(
                  operations: operations,
                  onSaved: onSaved ?? () {},
                )
              : const SizedBox(
                  height: 0,
                ),
        ],
      ),
    );
  }
}
