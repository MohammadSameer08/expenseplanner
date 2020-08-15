import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class NewTransaction extends StatefulWidget {
  final Function addTransactions;

  NewTransaction(this.addTransactions);

  @override
  _NewTransactionState createState() => _NewTransactionState();
}

class _NewTransactionState extends State<NewTransaction> {
  final titleController = TextEditingController();
  final amountController = TextEditingController();
  DateTime selectedDate;

  void update() {
    var titleEntered = titleController.text;
    var amountEntered = int.parse(amountController.text);
    if (titleEntered.isEmpty || amountEntered < 1 || selectedDate == null) {
      return;
    } else
      widget.addTransactions(titleEntered, amountEntered,
          selectedDate); // method which has setState(){}

    Navigator.of(context).pop(); // To close the bottom sheet...
  }

  void calenderPicker() {
    showDatePicker(
            context: context,
            initialDate: DateTime.now(),
            firstDate: DateTime(2020),
            lastDate: DateTime.now())
        .then((value) {
      setState(() {
        selectedDate = value;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Card(
        elevation: 5,
        child: Container(
          padding: EdgeInsets.only(
              top: 10,
              left: 10,
              right: 10,
              bottom: MediaQuery.of(context).viewInsets.bottom + 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              TextField(
                  autocorrect: true,
                  decoration: InputDecoration(
                      labelText: "Title", focusColor: Colors.purple),
                  /*onChanged: (val) {
                          titleInput = val;
                        },*/
                  controller: titleController,
                  onSubmitted: (val) => update()),
              TextField(
                  autocorrect: true,
                  decoration: InputDecoration(
                      labelText: "Price", focusColor: Colors.purple),
                  /*  onChanged: (val) {
                          amountInput = val;
                        },*/
                  controller: amountController,
                  keyboardType: TextInputType.number,
                  onSubmitted: (val) => update()),
              SizedBox(
                height: 50,
              ),
              Row(
                children: <Widget>[
                  Expanded(
                    child: FittedBox(
                      child: Text(
                        selectedDate == null
                            ? "No Date Chosen!"
                            : "Picked Date:" +
                                DateFormat.yMd().format(selectedDate),
                        style: TextStyle(fontSize: 18),
                      ),
                    ),
                  ),
                  FlatButton(
                    textColor: Colors.purple,
                    child: Text(
                      "Chose a date",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    onPressed: () {
                      calenderPicker();
                    },
                  ),
                ],
              ),
              RaisedButton(
                child: Text("Add Transaction"),
                color: Colors.purple,
                textColor: Colors.white,
                onPressed: () {
                  update();
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}
