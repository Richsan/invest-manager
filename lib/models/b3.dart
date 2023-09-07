import 'package:equatable/equatable.dart';
import 'package:invest_manager/components/b3.dart';

class Company extends Equatable {

  const Company({
    required this.cvmCode,
    required this.name,
    required this.issuingCompany,
    required this.tradingName,
    required this.taxId,
    required this.dateListing,
    this.marketIndicator = "",
    this.typeBDR = "",
    this.status = "",
    this.segment = "",
    this.segmentEng = "",
    this.type = "",
    this.market = "",
  });

  final String cvmCode;
  final String issuingCompany;
  final String name;
  final String tradingName;
  final String taxId;
  final String marketIndicator;
  final String typeBDR;
  final DateTime dateListing;
  final String status;
  final String segment;
  final String segmentEng;
  final String type;
  final String market;

  factory Company.fromJson(Map<String, dynamic> json) {
    return Company(
      cvmCode: json['codeCVM'],
      taxId: json['cnpj'],
      issuingCompany: json['issuingCompany'],
      name: json['companyName'],
      tradingName: json['tradingName'],
      marketIndicator: json['marketIndicator'],
      typeBDR: json['typeBDR'],
      dateListing: dateFormat.parse(json['dateListing']),
      status: json['status'],
      segment: json['segment'],
      segmentEng: json['segmentEng'],
      type: json['type'],
      market: json['market'],
    );
  }

  @override
  // TODO: implement props
  List<Object?> get props => [
        cvmCode,
        issuingCompany,
        name,
        tradingName,
        taxId,
        marketIndicator,
        typeBDR,
        dateListing,
        status,
        segment,
        segmentEng,
        type,
        market,
      ];
}