import 'package:flutter/material.dart';

class NewTransaction extends StatefulWidget {
  final Function addTx;

  NewTransaction({super.key, required this.addTx});

  @override
  State<NewTransaction> createState() => _NewTransactionState();
}

class _NewTransactionState extends State<NewTransaction> {
  final titleController = TextEditingController();

  final amountController = TextEditingController();

  void submitData() {
    final enteredTitle = titleController.text;
    final enteredAmount = double.parse(amountController.text);

    //validation
    if (enteredTitle.isEmpty || enteredAmount <= 0) {
      return;
    }

    //widget hanya terdapat di statefull, gunanya mempertahankan state
    //jadi ketika pindah kursor dari textfield ke textfield lain, isi datanya tidak hilang
    widget.addTx(
      enteredTitle,
      enteredAmount,
    );

    //untuk tutup modals nya or menutup screen teratas stack nya
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      child: Container(
        padding: EdgeInsets.all(10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            TextField(
              decoration: InputDecoration(labelText: 'Title'),
              controller: titleController,
              onSubmitted: (_) => submitData,
              /* onChanged: (value) {
                        titleInput = value;
                      }, */
            ),
            TextField(
              decoration: InputDecoration(labelText: 'Amount'),
              controller: amountController,
              keyboardType: TextInputType.numberWithOptions(decimal: true),
              onSubmitted: (_) => submitData,
              //onChanged: (value) => amountInput = value,
            ),
            TextButton(
              /* onPressed: () {
                addTx(
                  titleController.text,
                  double.parse(amountController.text),
                );
              }, */
              onPressed: submitData,
              child: Text(
                'Add Transaction',
                style: TextStyle(color: Colors.purple),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
