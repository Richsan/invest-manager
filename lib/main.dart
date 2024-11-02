import 'package:flutter/material.dart';
import 'package:invest_manager/repository/stock_operation.dart';
import 'package:invest_manager/screens/import_data.dart';
import 'package:invest_manager/screens/search.dart';
import 'package:invest_manager/screens/stock_list.dart';
import 'package:invest_manager/screens/tax_report.dart';

void main() async {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const HomePage(),
    );
  }
}

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Invest Manager'),
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            const DrawerHeader(
              decoration: BoxDecoration(
                color: Colors.blue,
              ),
              child: Text(
                'Menu',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                ),
              ),
            ),
            ListTile(
              title: const Text('Stock operation list'),
              onTap: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => StockOperationListScreen(
                      stockOperationsFuture: getAllStockOperations(),
                    ),
                  ),
                );
              },
            ),
            ListTile(
              title: const Text('Import data'),
              onTap: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => const ImportDataScreen(),
                  ),
                );
              },
            ),
            ListTile(
              title: const Text('Tax Report'),
              onTap: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => TaxReportScreen(),
                  ),
                );
              },
            ),
          ],
        ),
      ),
      body: const StockCompanySearch(),
    );
  }
}
