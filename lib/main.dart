import 'package:flutter/material.dart';
import 'package:flutter_expense_app/widgets/chart.dart';
import 'package:flutter_expense_app/widgets/user_transaction.dart';
import '/models/transaction.dart';
import '/widgets/new_transaction.dart';
import '/widgets/transaction_list.dart';
import 'package:intl/intl.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Expense App',
      theme: ThemeData(
        primarySwatch: Colors.purple,
        colorScheme: ColorScheme.fromSwatch(
          accentColor: Colors.amber,
          errorColor: Colors.red,
        ),
        fontFamily: 'Quicksand',
        textTheme: ThemeData.light().textTheme.copyWith(
              titleMedium: TextStyle(fontFamily: 'OpenSans'),
            ),
        appBarTheme: AppBarTheme(
          titleTextStyle: TextStyle(fontFamily: 'OpenSans', fontSize: 20, fontWeight: FontWeight.bold),
        ),
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  /* String titleInput = '';
  String amountInput = ''; */
  final List<Transaction> _userTransactions = [
    Transaction(id: 't1', title: 'New Shoes', amount: 69.33, date: DateTime.now()),
    Transaction(id: 't2', title: 'Weekly Groceries', amount: 16.55, date: DateTime.now().subtract(Duration(days: 1))),
    Transaction(id: 't3', title: 'Weekly Groceries', amount: 36.55, date: DateTime.now().subtract(Duration(days: 2))),
    Transaction(id: 't4', title: 'Weekly Groceries', amount: 46.55, date: DateTime.now().subtract(Duration(days: 2))),
    Transaction(id: 't5', title: 'Weekly Groceries', amount: 26.55, date: DateTime.now().subtract(Duration(days: 3))),
    Transaction(id: 't6', title: 'Weekly Groceries', amount: 6.55, date: DateTime.now().subtract(Duration(days: 4))),
    Transaction(id: 't7', title: 'Weekly Groceries', amount: 96.55, date: DateTime.now().subtract(Duration(days: 5))),
  ];

  //ambil transaksi terbaru saja
  List<Transaction> get _recentTransactions {
    return _userTransactions.where((tx) {
      //filter transaksi hanya sampai 7 hari terakhir
      return tx.date.isAfter(
        DateTime.now().subtract(
          const Duration(days: 7),
        ),
      );
    }).toList();
  }

  void _addNewTransaction(String title, double amount, DateTime chosenDate) {
    final newTx = Transaction(
      title: title,
      amount: amount,
      //date: DateTime.now(),
      date: chosenDate,
      id: DateTime.now().toString(),
    );

    setState(() {
      _userTransactions.add(newTx);
    });
  }

  void _startAddNewTransaction(BuildContext ctx) {
    showModalBottomSheet(
        context: ctx,
        builder: (bCtx) {
          return NewTransaction(addTx: _addNewTransaction);
        });
  }

  void _deleteTransaction(String id) {
    setState(() {
      _userTransactions.removeWhere((tx) => tx.id == id);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Expense App',
        ),
        actions: [
          IconButton(
            onPressed: () => _startAddNewTransaction(context),
            icon: Icon(Icons.add),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          //mainAxisAlignment: MainAxisAlignment.spaceAround,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Chart(recentTransactions: _recentTransactions),
            //UserTransaction(),
            TransactionList(_userTransactions, _deleteTransaction),
          ],
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FloatingActionButton(
        onPressed: () => _startAddNewTransaction(context),
        child: Icon(Icons.add),
      ),
    );
  }
}
