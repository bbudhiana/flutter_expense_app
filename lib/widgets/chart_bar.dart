import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';

class ChartBar extends StatelessWidget {
  const ChartBar(
    this.label,
    this.spendingAmount,
    this.spendingPctOfTotal,
  );
  final String label;
  final double spendingAmount;
  final double spendingPctOfTotal;

  @override
  Widget build(BuildContext context) {
    //menggunakan LayoutBuilder agar dapat memanfaatkan constraint (properti height, weight, dll)
    return LayoutBuilder(
      builder: (ctx, constraints) {
        return Column(
          children: [
            //FittedBox membuat text menjadi dinamis ukurannya mengikuti 'space' yg tersedia
            Container(
              //height: 20,
              height: constraints.maxHeight * 0.15,
              child: FittedBox(
                child: Text('\$${spendingAmount.toStringAsFixed(0)}'),
              ),
            ),
            SizedBox(
              height: constraints.maxHeight * 0.05,
            ),
            Container(
              //height: 60,
              height: constraints.maxHeight * 0.6,
              width: 10,
              child: Stack(children: [
                Container(
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey, width: 1.0),
                    color: Color.fromRGBO(220, 220, 220, 1),
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),
                FractionallySizedBox(
                  heightFactor: spendingPctOfTotal,
                  child: Container(
                    decoration: BoxDecoration(
                      color: Theme.of(context).primaryColor,
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ),
              ]),
            ),
            SizedBox(
              height: constraints.maxHeight * 0.05,
            ),
            Container(
              height: constraints.maxHeight * 0.15,
              child: FittedBox(child: Text(label)),
            ),
          ],
        );
      },
    );
  }
}
