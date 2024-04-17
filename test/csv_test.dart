import 'dart:convert';
import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:invest_manager/components/csv.dart';

void main() {
  test(
    'CSV to Map test',
    () {
      final String csvString =
          File('test/resources/stockops.csv').readAsStringSync();
      final List<dynamic> stockOpsJson =
          jsonDecode(File('test/resources/stockops.json').readAsStringSync());

      final List<Map<String, String>> csvMap = csvToMapList(csvString);

      expect(csvMap, stockOpsJson);
    },
  );
}
