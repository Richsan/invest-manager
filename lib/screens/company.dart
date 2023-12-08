import 'package:flutter/material.dart';
import 'package:invest_manager/models/b3.dart';
import 'package:invest_manager/screens/stock.dart';

class CompanyScreen extends StatelessWidget {
  const CompanyScreen({
    super.key,
    required this.company,
  });

  final Company company;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Company details"),
      ),
      body: Container(
        width: MediaQuery.of(context).size.width,
        margin: EdgeInsets.only(
          top: 30,
        ),
        child: Column(
          crossAxisAlignment:
              CrossAxisAlignment.center, // Centraliza horizontalmente
          children: [
            Text(company.name),
            Text(company.segment),
            Text(company.tradingName),
            Text(company.taxId),
            Text(company.cvmCode),
            Text(company.listedSince.toString()),
            Text(company.cvmCode),
            ...(company.tickers.map((e) => Text(e.b3code))),
            Text(company.website.toString()),
            Text(company.institutionPreferred),
            ButtonBar(
              buttonPadding: EdgeInsets.all(30),
              alignment: MainAxisAlignment.center,
              children: [
                ElevatedButton.icon(
                  icon: Icon(Icons.sell),
                  onPressed: () => Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => StockSellScreen(company: company),
                    ),
                  ),
                  label: Text("Vender", style: TextStyle(color: Colors.white)),
                  style: ButtonStyle(
                    backgroundColor:
                        MaterialStatePropertyAll<Color>(Colors.red),
                  ),
                ),
                ElevatedButton.icon(
                  icon: Icon(Icons.attach_money),
                  onPressed: () => Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => StockBuyScreen(company: company),
                    ),
                  ),
                  label: Text("Comprar", style: TextStyle(color: Colors.white)),
                  style: ButtonStyle(
                    backgroundColor:
                        MaterialStatePropertyAll<Color>(Colors.green),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
