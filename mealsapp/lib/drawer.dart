import 'package:flutter/material.dart';
import 'package:mealsapp/screens/filter_screen.dart';

class SideDrawer extends StatelessWidget {
  const SideDrawer(this.setfilters, {super.key});

  final void Function(Map<String, bool>) setfilters;
  void navigationhelper(BuildContext context) async {
    Navigator.of(context).pop();
    final Map<String, bool> filters = await Navigator.of(context)
        .push(MaterialPageRoute(builder: (BuildContext context) {
      return const FilterScreen();
    }));
    setfilters(filters);
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: [
          DrawerHeader(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
                gradient: LinearGradient(
              colors: [
                Theme.of(context).colorScheme.primaryContainer,
                Theme.of(context)
                    .colorScheme
                    .primaryContainer
                    .withOpacity(0.90),
              ],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            )),
            child: Row(
              children: [
                Icon(
                  Icons.cookie_outlined,
                  color: Theme.of(context).colorScheme.onPrimaryContainer,
                  size: 40,
                ),
                const SizedBox(
                  width: 10,
                ),
                Text(
                  'Cooking up !',
                  style: TextStyle(
                      color: Theme.of(context).colorScheme.onPrimaryContainer,
                      fontSize: 25),
                )
              ],
            ),
          ),
          ListTile(
            leading: const Icon(Icons.home),
            title: const Text('Home'),
            onTap: () {
              Navigator.of(context).pop();
            },
          ),
          ListTile(
            leading: const Icon(Icons.filter),
            title: const Text('Filter'),
            onTap: () {
              navigationhelper(context);
            },
          )
        ],
      ),
    );
  }
}
