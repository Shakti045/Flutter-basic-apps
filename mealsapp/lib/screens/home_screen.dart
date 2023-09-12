import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mealsapp/data/categorydata.dart';
import 'package:mealsapp/data/mealsdata.dart';
import 'package:mealsapp/model/category.dart';
import 'package:mealsapp/model/meal.dart';
import 'package:mealsapp/providers/filterprovider.dart';
import 'package:mealsapp/screens/category_screen.dart';

class HomeScreen extends ConsumerWidget {
  const HomeScreen(this.setfavouritemeals, {super.key});
  final void Function(Meal meal) setfavouritemeals;
  void _makenavigate(BuildContext context, Category category, filters) {
    List<Meal> meals = dummyMeals.where((meal) {
      return meal.categories.contains(category.id);
    }).toList();
    if (filters.keys.isNotEmpty) {
      meals = meals.where((meal) {
        if (filters[AvailaibleFilters.gluttenfree]! && !meal.isGlutenFree) {
          return false;
        }
        if (filters[AvailaibleFilters.lactosefree]! && !meal.isLactoseFree) {
          return false;
        }
        if (filters[AvailaibleFilters.veganmeals]! && !meal.isVegan) {
          return false;
        }
        if (filters[AvailaibleFilters.vegeterianmeals]! && !meal.isVegetarian) {
          return false;
        }
        return true;
      }).toList();
    }

    //   Navigator.push(context, route)=>this can be used
    Navigator.of(context)
        .push(MaterialPageRoute(builder: (BuildContext context) {
      return CategoryScreen(
          id: category.id,
          meals: meals,
          title: category.title,
          setfavouritemeals: setfavouritemeals);
    }));
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final filters = ref.watch(filterProvider);
    return Scaffold(
      // appBar: AppBar(
      //   title: const Text('Category'),
      // ),
      body: Padding(
        padding: const EdgeInsets.all(10),
        child: GridView(
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              childAspectRatio: 3 / 2,
              crossAxisSpacing: 20,
              mainAxisSpacing: 20),
          children: [
            for (Category category in availableCategories)
              InkWell(
                onTap: () => _makenavigate(context, category, filters),
                // splashColor:Colors.black,
                borderRadius: BorderRadius.circular(10),
                child: Container(
                  height: 100,
                  width: double.infinity,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      gradient: LinearGradient(colors: [
                        category.color.withOpacity(0.55),
                        category.color.withOpacity(0.9)
                      ], begin: Alignment.topLeft, end: Alignment.bottomRight)),
                  child: Center(
                    child: Text(
                      category.title,
                      style: const TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 18),
                    ),
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
