import 'package:expense_tracker/model/expencemodel.dart';
import 'package:flutter/material.dart';
import 'package:expense_tracker/data/expence_list.dart';
import 'package:expense_tracker/expancelist.dart';
import 'package:expense_tracker/create_expance.dart';

class ExpenceTeackerApp extends StatefulWidget {
  const ExpenceTeackerApp({super.key});
  @override
  State<ExpenceTeackerApp> createState() {
    return _ExpenceTeackerAppState();
  }
}

class _ExpenceTeackerAppState extends State<ExpenceTeackerApp> {
  List<Expence> allexpences = expenceslist;

  void setAllexpences(Expence expence) {
    setState(() {
      allexpences.add(expence);
    });
  }

  void removeExpance(Expence expence, int index) {
    setState(() {
      allexpences.remove(expence);
    });

    ScaffoldMessenger.of(context).clearSnackBars();
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: const Text('Expance item removed'),
      duration: const Duration(seconds: 3),
      action: SnackBarAction(
          label: 'undo',
          onPressed: () {
            setState(() {
              allexpences.insert(index, expence);
            });
          }),
    ));
  }

  void _showbottomModal() {
    showModalBottomSheet(
        context: context,
        builder: (BuildContext ctx) {
          return CreateExpance(setAllexpences);
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Expence tracker',
          style: TextStyle(color: Colors.white),
        ),
        actions: [
          IconButton(
            onPressed: _showbottomModal,
            icon: const Icon(Icons.add),
            style: IconButton.styleFrom(foregroundColor: Colors.white),
          )
        ],
        backgroundColor: const Color.fromARGB(255, 44, 2, 117),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Expanded(child: ExpanceList(allexpences, removeExpance)),
        ],
      ),
    );
  }
}
