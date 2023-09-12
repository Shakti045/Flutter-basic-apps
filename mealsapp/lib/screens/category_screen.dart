import 'package:flutter/material.dart';


import 'package:mealsapp/model/meal.dart';
import 'package:mealsapp/screens/meal_screen.dart';
import 'package:mealsapp/widget/meal.dart';

class CategoryScreen extends StatelessWidget {
  const CategoryScreen(
      {super.key,
      this.id,
      required this.title,
      required this.setfavouritemeals,
      required this.meals
      });

  final String? id;
  final String title;
  final void Function(Meal meal) setfavouritemeals;
  final List<Meal> meals;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: id != null
          ? AppBar(
              title: Text(title),
            )
          : null,
      body: meals.isEmpty
          ? Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    'No meals found',
                    style: TextStyle(
                        color: Theme.of(context).primaryColor, fontSize: 20),
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  Text(
                    'Try agin with other category',
                    style: TextStyle(
                        color: Theme.of(context).primaryColor, fontSize: 25),
                  )
                ],
              ),
            )
          : ListView.builder(
              itemCount: meals.length,
              itemBuilder: (BuildContext context, int index) => InkWell(
                  onTap: () {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (BuildContext context) =>
                            MealScreen(meals[index], setfavouritemeals)));
                  },
                  child: MealCard(meals[index])),
            ),
    );
  }
}
