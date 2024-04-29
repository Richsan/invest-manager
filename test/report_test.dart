import 'dart:convert';
import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:invest_manager/adapters/stock_operations.dart';
import 'package:invest_manager/components/csv.dart';
import 'package:invest_manager/logics/company.dart';
import 'package:invest_manager/logics/report.dart';
import 'package:invest_manager/models/b3.dart';

void main() {
  test(
    'Tax Report Test',
    () {
      final String csvString =
          File('test/resources/stockops2.csv').readAsStringSync();
      final String b3String = File('test/resources/b3.json').readAsStringSync();

      final List<Map<String, String>> csvMap = csvToMapList(csvString);

      final companies = (jsonDecode(b3String) as List<dynamic>)
          .map((e) => e as Map<String, dynamic>)
          .map(Company.fromJson)
          .toList();

      final opsList = csvMap
          .map((e) => e.toStockOperation(companies.getByTicker(e['ticker']!)))
          .toList();

      final opsFiltered = opsList
          .where((element) => element.liquidationDate.year < 2023)
          .toList();

      final report = taxReport(opsFiltered);

      expect(report.positions, []);
    },
  );
}
