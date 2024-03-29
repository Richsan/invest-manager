import 'package:flutter/material.dart';
import 'package:invest_manager/repository/stock_operation.dart';
import 'package:invest_manager/screens/search.dart';
import 'package:invest_manager/screens/stock_list.dart';

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
      home: const HomePage(title: 'Invest Manager'),
    );
  }
}

class HomePage extends StatefulWidget {
  final String title;

  const HomePage({Key? key, required this.title}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
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
            FutureBuilder(
              future: getAllStockOperations(),
              builder: (context, snapshot) => ListTile(
                title: Text('Stock operation list'),
                onTap: () {
                  // Implementar a navegação para a página aqui
                  Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => StockOperationListScreen(
                      stockOperations: snapshot.requireData,
                    ),
                  ));
                },
              ),
            ),
          ],
        ),
      ),
      body: const StockCompanySearch(),
    );
  }
}
