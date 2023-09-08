import 'package:expense_tracker/model/expencemodel.dart';
import 'package:flutter/material.dart';

class CreateExpance extends StatefulWidget {
  const CreateExpance(this.setAllexpences, {super.key});
  final void Function(Expence expence) setAllexpences;
  @override
  State<CreateExpance> createState() {
    return _CreateExpanceForm();
  }
}

class _CreateExpanceForm extends State<CreateExpance> {
  final _titlecontroller = TextEditingController();
  final _expenceamountcontroller = TextEditingController();
  Category choosedcategory = Category.work;
  DateTime? choosendate;
  void _showdatepicker() async {
    final now = DateTime.now();
    final initdate = DateTime(now.year - 1, now.month, now.day);
    final pickeddate = await showDatePicker(
        context: context, initialDate: now, firstDate: initdate, lastDate: now);
    setState(() {
      choosendate = pickeddate;
    });
  }

  @override
  void dispose() {
    _titlecontroller.dispose();
    _expenceamountcontroller.dispose();
    super.dispose();
  }

  void _createExpence() {
    if (_titlecontroller.text.isEmpty ||
        choosendate == null ||
        _expenceamountcontroller.text.isEmpty ||
        double.parse(_expenceamountcontroller.text) < 0) {
      showDialog(
          context: context,
          builder: (BuildContext ctx) {
            return AlertDialog(
              title: const Text('Invalid input'),
              content: const Text(
                  'Please make sure a valid title, amount, date and category was entered.'),
              actions: [
                TextButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: const Text('ok'))
              ],
            );
          });
      return;
    }
    widget.setAllexpences(Expence(
        title: _titlecontroller.text,
        amount: double.parse(_expenceamountcontroller.text),
        category: choosedcategory));
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 48, 16, 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          TextField(
            maxLength: 50,
            keyboardType: TextInputType.text,
            controller: _titlecontroller,
            decoration: const InputDecoration(
                label: Text('Enter title of your expence')),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: TextField(
                  keyboardType: TextInputType.number,
                  controller: _expenceamountcontroller,
                  decoration:
                      const InputDecoration(label: Text('Enter amount')),
                ),
              ),
              Expanded(
                  child: Row(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  choosendate != null
                      ? Text(formatter.format(choosendate!))
                      : const Text('Select date'),
                  IconButton(
                      onPressed: _showdatepicker,
                      icon: const Icon(Icons.calendar_today))
                ],
              ))
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              DropdownButton(
                  value: choosedcategory,
                  items: Category.values.map((e) {
                    return DropdownMenuItem(
                        value: e, child: Text(e.name.toUpperCase()));
                  }).toList(),
                  onChanged: (value) {
                    if (value == null) {
                      return;
                    }
                    setState(() {
                      choosedcategory = value;
                    });
                  }),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  TextButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: const Text('Cancel')),
                  ElevatedButton(
                      onPressed: _createExpence, child: const Text('Create'))
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}
