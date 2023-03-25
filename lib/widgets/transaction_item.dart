import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../models/transaction.dart';

class TransactionItem extends StatelessWidget {
  const TransactionItem({
    super.key,
    required this.transaction,
    required this.deleteTx,
  });

  final Transaction transaction;
  final Function deleteTx;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 5),
      child: ListTile(
        leading: CircleAvatar(
          radius: 30,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: FittedBox(
              child: Text('\$${transaction.amount}'),
            ),
          ),
        ),
        title: Text(
          transaction.title,
          style: Theme.of(context).textTheme.titleMedium,
        ),
        subtitle: Text(DateFormat.yMMMd().format(transaction.date)),
        trailing: MediaQuery.of(context).size.width > 460 //misal untuk pembedaan tampilan di landscape dan potret
            ? ElevatedButton.icon(
                //lanscape tampil icon dan text
                icon: const Icon(Icons.delete),
                label: const Text('Delete'),
                style: ButtonStyle(
                    backgroundColor: MaterialStateColor.resolveWith((states) => Colors.white),
                    foregroundColor: MaterialStateColor.resolveWith((states) => Theme.of(context).primaryColor),
                    elevation: MaterialStateProperty.all(0)),
                onPressed: () => deleteTx(
                      transaction.id,
                    ))
            : IconButton(
                //potrait tampil icon saja
                icon: const Icon(Icons.delete),
                onPressed: () => deleteTx(transaction.id),
                color: Theme.of(context).colorScheme.error,
              ),
      ),
    );
  }
}
