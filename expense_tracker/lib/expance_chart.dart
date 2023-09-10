import 'package:flutter/material.dart';
import 'package:expense_tracker/model/expencemodel.dart';

class ExpanceChart extends StatelessWidget {
  const ExpanceChart(this.allexpences, {super.key});
  final List<Expence> allexpences;

  @override
  Widget build(BuildContext context) {
    List<Expence> expensescoapy = List.of(allexpences);
    expensescoapy.sort((a, b) {
      final list = a.amount.compareTo(b.amount);
      return -list;
    });
    Map<Category, double> categorydata = {};
    for (Expence expence in allexpences) {
      var dataexists = categorydata.containsKey(expence.category);
      if (dataexists) {
        categorydata[expence.category] =
            categorydata[expence.category]! + expence.amount;
      } else {
        categorydata[expence.category] = expence.amount;
      }
    }
    final categoryvalues = List.of(categorydata.values);
    categoryvalues.sort();
    final double highestprice = categoryvalues[categoryvalues.length - 1];
    return Row(
      crossAxisAlignment: CrossAxisAlignment.end,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        for (Category category in Category.values)
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: FractionallySizedBox(
                heightFactor: categorydata.containsKey(category)
                    ? categorydata[category]! / highestprice
                    : 0,
                child:  DecoratedBox(
                  decoration: BoxDecoration(
                      color:Theme.of(context).colorScheme.primary,
                      shape: BoxShape.rectangle,
                      borderRadius:
                         const BorderRadius.vertical(top: Radius.circular(5))),
                ),
              ),
            ),
          ),
      ],
    );
  }
}
