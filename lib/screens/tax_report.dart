import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:invest_manager/adapters/number.dart';
import 'package:invest_manager/logics/report.dart';
import 'package:invest_manager/models/stock_operation.dart';
import 'package:invest_manager/repository/stock_operation.dart';
import 'package:invest_manager/screens/bloc/screen_loader/bloc.dart';
import 'package:invest_manager/widgets/output.dart';

class TaxReport extends StatelessWidget {
  const TaxReport({
    super.key,
    required this.report,
  });

  final StockOperationTaxReport report;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          const Text('Bens e Direitos: '),
          const Divider(
            height: 10,
          ),
          ListView.builder(
            physics: const ClampingScrollPhysics(),
            padding: const EdgeInsets.all(8),
            shrinkWrap: true,
            scrollDirection: Axis.vertical,
            itemCount: report.positions.length,
            itemBuilder: (context, index) => Card(
              child: ListTile(
                title: Text('${report.positions[index].ticker}'
                    ' - Current Value: ${report.positions[index].total.asCurrency()}'),
                subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ValueDisplay(
                          label: 'CNPJ',
                          value: report.positions[index].company.taxId),
                      const SizedBox(
                        height: 10,
                      ),
                      Text('ACOES ${report.positions[index].ticker} //'
                          ' ${report.positions[index].unities} UNIDADES //'
                          ' CUSTO MEDIO R\$ ${report.positions[index].weightedValue.toStringAsPrecision(4)} //'
                          ' EMPRESA ${report.positions[index].company.name} //'
                          ' CUSTODIA NA CORRETORA XPINVESTIMENTOS CCTVMS/A CNPJ: 02.332.886/0001-04'),
                    ]),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class TaxReportScreen extends StatelessWidget {
  TaxReportScreen({
    super.key,
    int? year,
  }) : year = year ?? DateTime.now().year;

  final int year;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Tax Report'),
      ),
      body: BlocProvider(
        create: (context) => LoaderScreenBloc(data: getAllStockOperations()),
        child: BlocBuilder<LoaderScreenBloc, LoaderScreenState>(
          builder: (context, state) {
            if (state is InitialLoaderScreenState) {
              BlocProvider.of<LoaderScreenBloc>(context).add(
                LoadScreenEvent(data: state.data),
              );
              return const Text('loading...');
            }

            if (state is LoadingState) {
              return const Text('loading...');
            }

            if (state is LoadedState) {
              final List<StockOperation> operations = state.data;
              final reportOps = operations
                  .where((element) => element.liquidationDate.year < year)
                  .toList();
              return TaxReport(report: taxReport(reportOps));
            }

            return const Text('error');
          },
        ),
      ),
    );
  }
}
