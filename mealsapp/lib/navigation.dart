import 'package:flutter/material.dart';
import 'package:mealsapp/drawer.dart';
import 'package:mealsapp/model/meal.dart';
import 'package:mealsapp/providers/favouriteprovider.dart';
import 'package:mealsapp/screens/category_screen.dart';
import 'package:mealsapp/screens/home_screen.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class TabNavigator extends ConsumerStatefulWidget {
  const TabNavigator({super.key});

  @override
  ConsumerState<TabNavigator> createState() {
    return _TabState();
  }
}

class _TabState extends ConsumerState<TabNavigator> {
  Map<String, bool> filters = {};
  int tabindex = 0;
  List<Meal> favouritemeals = [];

  void setfilters(Map<String, bool> filter) {
    setState(() {
      filters = filter;
    });
  }

  void setfavouritemeals(Meal meal) {
    final isexists = favouritemeals.contains(meal);
    if (isexists) {
      setState(() {
        favouritemeals.remove(meal);
      });
      ScaffoldMessenger.of(context).clearSnackBars();
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text('Item removed from favourite'),
        duration: Duration(seconds: 4),
      ));
    } else {
      setState(() {
        favouritemeals.add(meal);
      });
      ScaffoldMessenger.of(context).clearSnackBars();
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text('Item added to favourite meal'),
        duration: Duration(seconds: 4),
      ));
    }
  }

  void _settabindex(int index) {
    setState(() {
      tabindex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(tabindex == 0 ? 'Category' : 'My favourites'),
      ),
      drawer: SideDrawer(setfilters),
      body: tabindex == 0
          ? HomeScreen(setfavouritemeals)
          : CategoryScreen(
              title: 'My Favourites',
              setfavouritemeals: setfavouritemeals,
              meals: ref.watch(favouriteMealsProvider)),
      bottomNavigationBar: BottomNavigationBar(
          onTap: (index) {
            _settabindex(index);
          },
          backgroundColor: Theme.of(context).colorScheme.surface,
          currentIndex: tabindex,
          items: const [
            BottomNavigationBarItem(
              icon: Icon(Icons.category),
              label: 'Category',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.favorite_outline_rounded),
              label: 'Favourite',
            )
          ]),
    );
  }
}
