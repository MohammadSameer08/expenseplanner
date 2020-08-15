import 'package:flutter/cupertino.dart';

import '../models/Transaction.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'Transactionitem.dart';

class TransactionList extends StatelessWidget {
  final List<Transaction> transactions;
  final Function deleteTransaction;

  TransactionList(this.transactions, this.deleteTransaction);

  @override
  Widget build(BuildContext context) {
    return Container(
        child: transactions.isEmpty
            ? LayoutBuilder(builder: (ctx, constrains) {
                return Column(
                  children: <Widget>[
                    Text(
                      "No transaction is added yet!",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 18,
                        color: Colors.blue,
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Center(
                      child: Container(
                          height: constrains.maxHeight * 0.7,
                          child: Image.asset("images/waiting.png",
                              fit: BoxFit.cover, alignment: Alignment.center)),
                    ),
                  ],
                );
              })
            : ListView(
                children: transactions
                    .map((tx) => TransactionItem(
                         key:ValueKey(tx.id),
                        transaction: tx, deleteTransaction: deleteTransaction))
                    .toList(),
              )

        /*ListView.builder(
                itemBuilder: (ctx, index) {
                  return TransactionItem(transaction: transactions[index], deleteTransaction: deleteTransaction);
                },
                itemCount: transactions.length,
              )*/

        );
  }
}

/*
 return (Card(
                    child: Row(
                      children: <Widget>[
                        Container(
                          child: Text(
                            "Rs:" + transactions[index].amount.toString(),
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Theme.of(context).primaryColor,
                                fontSize: 20),
                          ),
                          margin: EdgeInsets.all(10),
                          decoration: BoxDecoration(
                            border: Border.all(
                              color: Theme.of(context).primaryColor,
                              width: 2,
                            ),
                          ),
                          padding: EdgeInsets.all(10),
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text(
                              transactions[index].title,
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black,
                                  fontSize: 18),
                            ),
                            Text(
                                DateFormat.yMMMd()
                                    .format(transactions[index].date),
                                style: TextStyle(
                                  color: Colors.grey,
                                )),
                          ],
                        )
                      ],
                    ),
                  ));

 */
