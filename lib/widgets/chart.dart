import 'package:flutter/material.dart';
import 'package:flutter_expense_app/widgets/chart_bar.dart';
import 'package:intl/intl.dart';

import '../models/transaction.dart';

class Chart extends StatelessWidget {
  const Chart({Key? key, required this.recentTransactions}) : super(key: key);

  final List<Transaction> recentTransactions;

  List<Map<String, Object>> get groupedTransactionValues {
    return List.generate(7, (index) {
      final weekDay = DateTime.now().subtract(Duration(days: index));

      var totalSum = 0.0;

      /* for (var i = 0; i < recentTransactions.length; i++) {
        if (recentTransactions[i].date.day == weekDay.day &&
            recentTransactions[i].date.month == weekDay.month &&
            recentTransactions[i].date.year == weekDay.year) {
          totalSum += recentTransactions[i].amount;
        }
      } */

      for (var tx in recentTransactions) {
        if (tx.date.day == weekDay.day && tx.date.month == weekDay.month && tx.date.year == weekDay.year) {
          totalSum += tx.amount;
        }
      }

      //sat
      //fri
      //..
      print(DateFormat.E().format(weekDay));

      //[{day: Sat, amount: 168.63000000000002}, {day: Fri, amount: 0.0}, {day: Thu, amount: 0.0},
      //{day: Wed, amount: 0.0}, {day: Tue, amount: 0.0}, {day: Mon, amount: 0.0}, {day: Sun, amount: 0.0}]
      return {
        'day': DateFormat.E().format(weekDay).substring(0, 1),
        'amount': totalSum,
      };
    }).reversed.toList();
    //di reverse urutan list nya agar urut dari kiri ke kanan dari terlama ke terbaru
  }

  //total spending dari transaksi
  double get totalSpending {
    //fold : nilai total dari semua value yg ada dalam list, filter sesuai kriteria dan formula
    //perhitungan dari initialvalue yaitu 0.0
    return groupedTransactionValues.fold(0.0, (sum, item) {
      //sum dimulai dari 0.0
      //perlu di cast dengan as double karena belum mengerti si item itu number or double tipe nya
      return sum + (item['amount'] as double);
    });
  }

  @override
  Widget build(BuildContext context) {
    print(groupedTransactionValues);
    return Card(
      elevation: 6,
      margin: const EdgeInsets.all(20),
      child: Padding(
        padding: EdgeInsets.all(10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: groupedTransactionValues.map((data) {
            //return Text('${data['day']} : ${data['amount']}');
            return Flexible(
              fit: FlexFit.tight, //dengan flexible,setiap child dapat space yg sama
              child: ChartBar(
                data['day'] as String,
                data['amount'] as double,
                totalSpending == 0.0 ? 0.0 : ((data['amount'] as double) / totalSpending),
              ),
            );
          }).toList(),
        ),
      ),
    );
  }
}
