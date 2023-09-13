import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutterform/data/categories.dart';
import 'package:flutterform/model/categorymodel.dart';
import 'package:flutterform/model/groceryitem.dart';
import 'package:http/http.dart' as http;

class AddItemScreen extends StatefulWidget {
  const AddItemScreen({super.key});

  @override
  State<AddItemScreen> createState() {
    return _AddItemScreenState();
  }
}

class _AddItemScreenState extends State<AddItemScreen> {
  final _formkey = GlobalKey<FormState>();

  String? _itemname;
  int? _quantity;
  String _categoryname = "Vegetables";
  bool isloading = false;

  void createitem() async {
    final url = Uri.https(
        'flutter-cc06b-default-rtdb.asia-southeast1.firebasedatabase.app',
        'groceryitems.json');

    try {
      setState(() {
        isloading = true;
      });
      final result = await http.post(url,
          headers: {
            'Content-Type': 'application/json',
          },
          body: json.encode({
            "itemname": _itemname,
            "quantity": _quantity,
            "categoryname": _categoryname
          }));
      final Category category =
          categories.entries.firstWhere((item) => item.value.title==_categoryname).value;

      final Map<String, dynamic> responce = json.decode(result.body);
      if (context.mounted) {
        Navigator.of(context).pop(GroceryItem(
            id: responce['name'],
            name: _itemname!,
            quantity: _quantity!,
            category: category));
      }
    } catch (error) {
      if (context.mounted) {
        ScaffoldMessenger.of(context).clearSnackBars();
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
            content: Text('Something went wrong please try again')));
      }
      return;
    } finally {
      setState(() {
        isloading = false;
      });
    }
  }

  void submitform() {
    if (_formkey.currentState!.validate()) {
      _formkey.currentState!.save();
      createitem();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add items to grocerylist'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(12),
        child: Form(
            key: _formkey,
            child: Column(
              children: [
                TextFormField(
                  decoration: const InputDecoration(
                    label: Text('Enter your grocery name'),
                  ),
                  maxLength: 50,
                  onSaved: (String? value) {
                    if (value == null) {
                      return;
                    }
                    _itemname = value;
                  },
                  validator: (String? value) {
                    if (value == null ||
                        value.isEmpty ||
                        value.trim().isEmpty ||
                        value.trim().length <= 1) {
                      return 'Name must be a valid name';
                    }
                    return null;
                  },
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Expanded(
                      child: TextFormField(
                        keyboardType: TextInputType.number,
                        decoration: const InputDecoration(
                            label: Text('Enter quantity')),
                        initialValue: '1',
                        onSaved: (String? value) {
                          if (value == null) {
                            return;
                          }
                          _quantity = int.parse(value);
                        },
                        validator: (String? value) {
                          if (value == null ||
                              value.isEmpty ||
                              value.trim().isEmpty ||
                              int.tryParse(value) == null ||
                              int.parse(value) <= 0) {
                            return 'Must be a valid number ';
                          }
                          return null;
                        },
                      ),
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    Expanded(
                      child: DropdownButtonFormField(
                          onSaved: (value) {
                            print(value);
                          },
                          value: _categoryname,
                          dropdownColor:
                              Theme.of(context).colorScheme.secondaryContainer,
                          decoration: const InputDecoration(
                              label: Text('Select category')),
                          items: [
                            for (final category in categories.entries)
                              DropdownMenuItem(
                                  value: category.value.title,
                                  child: Row(
                                    children: [
                                      Container(
                                        height: 10,
                                        width: 10,
                                        color: category.value.color,
                                      ),
                                      const SizedBox(
                                        width: 10,
                                      ),
                                      Text(category.value.title),
                                    ],
                                  ))
                          ],
                          onChanged: (value) {
                            _categoryname = value!;
                          }),
                    )
                  ],
                ),
                const SizedBox(
                  height: 15,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    ElevatedButton(
                        onPressed:isloading?null: () {
                          _formkey.currentState!.reset();
                          _categoryname = "Vegetables";
                        },
                        child: const Text('Reset')),
                    const SizedBox(
                      width: 10,
                    ),
                    ElevatedButton(
                        onPressed:isloading?null: submitform, 
                         child:isloading?const Padding(
                          padding: EdgeInsets.all(10),
                          child:  CircularProgressIndicator()):
                          const Text('Submit'))
                  ],
                ),
              ],
            )),
      ),
    );
  }
}
