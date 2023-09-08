import 'package:expense_tracker/model/expencemodel.dart';
import 'package:flutter/material.dart';

class ExpanceList extends StatelessWidget {
  const ExpanceList(this.expancelist, this.removeExpance, {super.key});
  final List<Expence> expancelist;
  final void Function(Expence expence,int index) removeExpance;
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        itemCount: expancelist.length,
        itemBuilder: (BuildContext ctx, int index) {
          return Dismissible(
            key: ValueKey(expancelist[index]),
            onDismissed: (direction) {
              removeExpance(expancelist[index],index);
            },
            child: Card(
              margin: const EdgeInsets.all(10),
              child: Padding(
                padding: const EdgeInsets.all(10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(expancelist[index].title),
                    const SizedBox(
                      height: 8,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(expancelist[index].amount.toStringAsFixed(2)),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            expancelist[index].categoryIcon,
                            const SizedBox(
                              width: 8,
                            ),
                            Text(expancelist[index].createdat)
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          );
        });
  }
}
