import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:invest_manager/models/b3.dart';

Future<String> _listedCompanyFile() => rootBundle.loadString('assets/b3.json');

final dateFormat = DateFormat("dd/MM/yyyy");

Future<List<Company>> _listedCompanies() async {
  final String jsonStr = await _listedCompanyFile();
  final List<dynamic> jsonEntries = jsonDecode(jsonStr);

  return jsonEntries
      .map((e) => e as Map<String, dynamic>)
      .map(Company.fromJson)
      .toList();
}

Future<List<Company>> listedCompanies = _listedCompanies();

Future<List<Company>> searchListedCompanies(String search) async {
  final companies = await listedCompanies;

  return companies
      .where((element) =>
          element.name.toUpperCase().contains(search.toUpperCase()))
      .toList();
}

Future<Company> companyByTicker(String ticker) async {
  final companies = await listedCompanies;

  return companies.firstWhere((company) => company.tickers
      .map((companyTicker) => companyTicker.b3code)
      .contains(ticker));
}
