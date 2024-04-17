import 'package:csv/csv.dart';

const _csvToListConverter = CsvToListConverter();

List<Map<String, String>> csvToMapList(String csvString) {
  final List<List<dynamic>> csvData = _csvToListConverter.convert(csvString);

  // Obter cabeçalhos
  List<String> headers = csvData[0].map((header) => header.toString()).toList();

  // Remover a primeira linha que contém os cabeçalhos
  csvData.removeAt(0);

  List<Map<String, String>> listMap = [];

  for (var data in csvData) {
    Map<String, String> resultMap = {};
    for (int i = 0; i < headers.length; i++) {
      resultMap[headers[i]] = data[i].toString();
    }
    listMap.add(resultMap);
  }

  return listMap;
}
