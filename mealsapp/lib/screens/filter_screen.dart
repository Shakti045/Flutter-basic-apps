import 'package:flutter/material.dart';

class FilterScreen extends StatefulWidget {
  const FilterScreen({super.key});

  @override
  State<FilterScreen> createState() {
    return _FilterScreenState();
  }
}

class _FilterScreenState extends State<FilterScreen> {
  bool _vegeterianmeals = false;
  bool _gluttefree = false;
  bool _lactosefree = false;
  bool _veganmeals = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Filter meals by your choice'),
      ),
      body: WillPopScope(
        onWillPop: () async {
          Navigator.of(context).pop(
            {
              "vegeterianmeals":_vegeterianmeals,
              "veganmeals":_veganmeals,
              "lactosefree":_lactosefree,
              "gluttenfree":_gluttefree
            }
          );
          return false;
        },
        child: Column(
          children: [
            SwitchListTile(
              title: const Text(
                'Vegeterian only',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.w900),
              ),
              subtitle: const Text('Only vegeterian meals will display'),
              onChanged: (value) {
                setState(() {
                  _vegeterianmeals = value;
                });
              },
              value: _vegeterianmeals,
            ),
            SwitchListTile(
              value: _gluttefree,
              onChanged: (value) {
                setState(() {
                  _gluttefree = value;
                });
              },
              title: const Text(
                'Glutter-Free',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.w900),
              ),
              subtitle: const Text('Only includes glutten-free meals'),
            ),
            SwitchListTile(
              value: _lactosefree,
              onChanged: (value) {
                setState(() {
                  _lactosefree = value;
                });
              },
              title: const Text(
                'Lactose-Free',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.w900),
              ),
              subtitle: const Text('Only includees lactose-free meals'),
            ),
            SwitchListTile(
              value: _veganmeals,
              onChanged: (value) {
                setState(() {
                  _veganmeals = value;
                });
              },
              title: const Text(
                'Vegan meals',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.w900),
              ),
              subtitle: const Text('Only includees lvegan meals'),
            )
          ],
        ),
      ),
    );
  }
}
