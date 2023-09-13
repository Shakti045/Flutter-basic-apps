import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutterform/data/categories.dart';
import 'package:flutterform/model/categorymodel.dart';
import 'package:flutterform/model/groceryitem.dart';
import 'package:flutterform/screens/add_item_screen.dart';

import 'package:http/http.dart' as http;

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() {
    return _HomeScreenState();
  }
}

class _HomeScreenState extends State<HomeScreen> {
  List<GroceryItem> groceryitems = [];

  String? errortext;
  bool isloading = false;

  void fetchitems() async {
    final url = Uri.https(
        'flutter-cc06b-default-rtdb.asia-southeast1.firebasedatabase.app',
        'groceryitems.json');

    setState(() {
      isloading = true;
    });

    try {
      final result = await http.get(url);
      if (result.statusCode >= 400) {
        throw Exception('Error while getting data from firebase');
      }
      if (result.body == 'null') {
        return;
        // setState(() {
        //   groceryitems = [];
        // });
      }

      final List<GroceryItem> loadeditems = [];
      final Map<String, dynamic> responce = json.decode(result.body);
      for (final item in responce.entries) {
        final category = categories.entries
            .firstWhere(
                (element) => element.value.title == item.value['categoryname'])
            .value;

        loadeditems.add(GroceryItem(
            id: item.key,
            name: item.value['itemname'],
            quantity: item.value['quantity'],
            category: category));
      }

      setState(() {
        groceryitems = loadeditems;
      });
    } catch (err) {
      setState(() {
        errortext = err.toString();
      });
    } finally {
      setState(() {
        isloading = false;
      });
    }
  }

  @override
  void initState() {
    super.initState();
    fetchitems();
  }

  void _navigationhelper() async {
    final GroceryItem result = await Navigator.of(context).push(
        MaterialPageRoute(
            builder: (BuildContext context) => const AddItemScreen()));
    setState(() {
      groceryitems.add(result);
    });
  }

  @override
  Widget build(BuildContext context) {
    Widget content = const Center(
      child: Text('No items added till now try addding new'),
    );

    if (isloading) {
      content = const Center(
        child: CircularProgressIndicator(),
      );
    }

    if (errortext != null) {
      content = Center(
        child: Text(errortext!),
      );
    }

    if (groceryitems.isNotEmpty) {
      content = ListView.builder(
          itemCount: groceryitems.length,
          itemBuilder: (BuildContext context, int index) {
            return Dismissible(
              key: ValueKey(groceryitems[index].id),
              onDismissed: (direction) {
                setState(() {
                  groceryitems.remove(groceryitems[index]);
                });
                final url = Uri.https(
                    'flutter-cc06b-default-rtdb.asia-southeast1.firebasedatabase.app',
                    'groceryitems/${groceryitems[index].id}.json');
                     http.delete(url);
              },
              child: ListTile(
                leading: Container(
                  height: 20,
                  width: 20,
                  color: groceryitems[index].category.color,
                ),
                title: Text(groceryitems[index].name),
                trailing: Text(groceryitems[index].quantity.toString()),
              ),
            );
          });
    }
    return Scaffold(
      appBar: AppBar(
        title: const Text('Grocery Items'),
        actions: [
          IconButton(onPressed: _navigationhelper, icon: const Icon(Icons.add))
        ],
      ),
      body: content,
    );
  }
}
