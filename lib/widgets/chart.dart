import 'package:expenseplanner/models/Transaction.dart';
import 'package:expenseplanner/widgets/chartBars.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class Chart extends StatelessWidget {
  final List<Transaction> recentTransaction;

  Chart(this.recentTransaction);

  List<Map<String, Object>> get groupedTransactionValue {
    return List.generate(7, (index) {
      var weekday = DateTime.now().subtract(Duration(days: index));
      int totalSum = 0;

      for (int i = 0; i < recentTransaction.length; i++) {
        if (recentTransaction[i].date.day == weekday.day &&
            recentTransaction[i].date.month == weekday.month &&
            recentTransaction[i].date.year == weekday.year) {
          totalSum = totalSum + recentTransaction[i].amount;
        }
      }

      return {
        'day': DateFormat.E().format(weekday),
        'amount': totalSum
      };
    }).reversed.toList();
  }

  double get totalAmount {
    return groupedTransactionValue.fold(0.0, (sum, data) {
      return sum = sum + data["amount"];
    });
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 6,
      margin: EdgeInsets.all(20),
      child: Container(
        padding: EdgeInsets.all(10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: groupedTransactionValue.map((data) {
            return Flexible(
              fit: FlexFit.tight,
              child: ChartBars(data["day"], data["amount"],
                  (totalAmount==0.0) ? 0.0 : (data["amount"] as int).toDouble() /
                  totalAmount),
            );
          }).toList(),
        ),
      ),
    );
  }
}
