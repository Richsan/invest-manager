import 'dart:convert';

import 'package:equatable/equatable.dart';
import 'package:invest_manager/components/b3.dart';

class CompanyTicker extends Equatable {
  const CompanyTicker({
    required this.b3code,
    this.isinCode = "",
  });

  final String b3code;
  final String isinCode;

  factory CompanyTicker.fromJson(Map<String, dynamic> json) {
    return CompanyTicker(
      b3code: json["code"],
      isinCode: json["isin"],
    );
  }

  @override
  List<Object> get props => [
        b3code,
        isinCode,
      ];
}

class Company extends Equatable {
  const Company({
    required this.cvmCode,
    required this.name,
    required this.issuingCompany,
    required this.tradingName,
    required this.taxId,
    required this.listedSince,
    this.status = "",
    this.segment = "",
    this.tickers = const [],
    this.activity = "",
    this.industryCassification = "",
    this.institutionCommon = "",
    this.institutionPreferred = "",
    this.website,
  });

  final String cvmCode;
  final String issuingCompany;
  final String name;
  final String tradingName;
  final String taxId;
  final String status;
  final String segment;
  final DateTime listedSince;
  final List<CompanyTicker> tickers;
  final String industryCassification;
  final String activity;
  final String institutionCommon;
  final String institutionPreferred;
  final Uri? website;

  factory Company.fromJson(Map<String, dynamic> json) {
    return Company(
      cvmCode: json['codeCVM'],
      taxId: json['cnpj'],
      issuingCompany: json['issuingCompany'],
      name: json['companyName'],
      tradingName: json['tradingName'],
      status: json['status'],
      segment: json['segment'],
      listedSince: dateFormat.parse(json['dateListing']),
      tickers: (jsonDecode(json["codes"]) as List<dynamic>)
          .map((e) => e as Map<String, dynamic>)
          .map(CompanyTicker.fromJson)
          .toList(),
      industryCassification: json["industryClassification"],
      institutionCommon: json['institutionCommon'],
      activity: json['activity'],
      institutionPreferred: json['institutionPreferred'],
      website: Uri.tryParse(json['website']),
    );
  }

  @override
  List<Object?> get props => [
        cvmCode,
        issuingCompany,
        name,
        tradingName,
        taxId,
        status,
        segment,
        listedSince,
        tickers,
        institutionPreferred,
        institutionCommon,
        industryCassification,
        activity,
        website,
      ];
}
