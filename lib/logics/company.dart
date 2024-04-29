import 'package:invest_manager/models/b3.dart';

extension CompaniesExt on List<Company> {
  Company getByTicker(String ticker) => firstWhere((company) => company.tickers
      .map((companyTicker) => companyTicker.b3code)
      .contains(ticker));
}
