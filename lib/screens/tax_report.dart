import 'package:collection/collection.dart';
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
    final profitsByMonth = report.sellProfits.groupListsBy(
      (element) => element.liquidationDate.month,
    );

    return SingleChildScrollView(
      child: Column(
        children: [
          ExpansionTile(
            title: const Text('Bens e Direitos: '),
            children: [
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
                              ' CUSTO MEDIO R\$ ${report.positions[index].weightedValue} //'
                              ' EMPRESA ${report.positions[index].company.name} //'
                              ' CUSTODIA NA CORRETORA XP INVESTIMENTOS CCTVMS/A CNPJ: 02.332.886/0001-04'),
                        ]),
                  ),
                ),
              ),
            ],
          ),
          ExpansionTile(
            title: Text('Vendas'),
            subtitle: Column(
              children: [
                const SizedBox(
                  height: 5,
                ),
                const Text('RENDIMENTOS ISENTOS E NÃO TRIBUTÁVEIS'),
                const SizedBox(
                  height: 5,
                ),
                const Text('20. Ganhos líquidos em operações no mercado à vista'
                    ' de ações negociadas em bolsas de valores nas alienações'
                    ' realizadas até R\$ 20.000,00, em cada mês, para o conjunto de ações'),
                const SizedBox(
                  height: 5,
                ),
                ValueDisplay(
                  label: 'Total Profit',
                  value: report.sellProfits
                      .where((element) => element.profitAmount > BigInt.zero)
                      .map((e) => e.profitAmount)
                      .reduce((value, element) => value + element)
                      .asCurrency(),
                )
              ],
            ),
            children: [
              ListView.builder(
                physics: const ClampingScrollPhysics(),
                padding: const EdgeInsets.all(8),
                shrinkWrap: true,
                scrollDirection: Axis.vertical,
                itemCount: 12,
                itemBuilder: (context, index) => Card(
                  child: ListTile(
                    title: Text(index.toMonth()),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        ...(profitsByMonth[index]?.map((e) => ListTile(
                                  title: Text('${e.ticker}'),
                                  subtitle: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      ValueDisplay(
                                        label: 'Sold',
                                        value:
                                            '${e.soldUnities} x ${e.soldValue.asCurrency()} = ${(e.soldValue * e.soldUnities).asCurrency()}',
                                      ),
                                      ValueDisplay(
                                        label: 'Profit',
                                        value: e.profitAmount.asCurrency(),
                                      ),
                                    ],
                                  ),
                                )) ??
                            []),
                        ValueDisplay(
                          label: 'Total Sold',
                          value: (profitsByMonth[index]
                                      ?.map((e) => e.soldUnities * e.soldValue)
                                      .reduce((value, element) =>
                                          value + element) ??
                                  BigInt.zero)
                              .asCurrency(),
                        ),
                        ValueDisplay(
                          label: 'Profit Total',
                          value: (profitsByMonth[index]
                                      ?.map((e) => e.profitAmount)
                                      .reduce((value, element) =>
                                          value + element) ??
                                  BigInt.zero)
                              .asCurrency(),
                        ),
                      ],
                    ),
                  ),
                ),
              )
            ],
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
              return TaxReport(
                report: taxReport(reportOps, year),
              );
            }

            return const Text('error');
          },
        ),
      ),
    );
  }
}
