import 'package:flutter/material.dart';

class ChartBars extends StatelessWidget {
  final String label;
  final int spendingAmount;
  final double spendingPercentageOfTotal;

  ChartBars(this.label, this.spendingAmount, this.spendingPercentageOfTotal);

  String get rupees {
    if (spendingAmount >= 1000 && spendingAmount <= 999999) {
      return (spendingAmount / 1000).toString() + "K";
    } else if (spendingAmount >= 1000000) {
      return (spendingAmount / 1000000).toString() + "M";
    } else
      return spendingAmount.toString();
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (ctx, constrains) {
      return Column(
        children: <Widget>[
          FittedBox(child: Text(rupees)),
          SizedBox(
            height: 4,
          ),
          Container(
            height: constrains.maxHeight*0.5,
            width: 10,
            child: Stack(
              children: <Widget>[
                Container(
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey, width: 1),
                    color: Color.fromRGBO(220, 220, 220, 1),
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                FractionallySizedBox(
                  heightFactor: spendingPercentageOfTotal,
                  // 0 to 1 :0->null,1->full....
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.purple,
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(
            height: 4,
          ),
          FittedBox(child: Text(label)), //week days Sun Mon Tue W T F S .
        ],
      );
    });
  }
}
