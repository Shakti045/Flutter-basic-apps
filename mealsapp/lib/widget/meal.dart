import 'package:flutter/material.dart';

import 'package:mealsapp/model/meal.dart';
import 'package:mealsapp/widget/meal_item_objectives.dart';
import 'package:transparent_image/transparent_image.dart';

class MealCard extends StatelessWidget {
  const MealCard(this.meal, {super.key});

  final Meal meal;

  String get affordabletext {
    return meal.affordability.name[0].toUpperCase() +
        meal.affordability.name[0].substring(1);
  }

  String get complexitytext {
    return meal.complexity.name[0].toUpperCase() +
        meal.complexity.name.substring(1);
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.all(16),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      clipBehavior: Clip.hardEdge,
      elevation: 2,
      child: Stack(
        children: [
          FadeInImage(
            placeholder: MemoryImage(kTransparentImage),
            image: NetworkImage(meal.imageUrl),
            fit: BoxFit.cover,
            height: 200,
            width: double.infinity,
          ),
          Positioned(
              left: 0,
              right: 0,
              bottom: 0,
              child: Container(
                color: const Color.fromARGB(117, 0, 0, 0),
                padding: const EdgeInsets.symmetric(vertical: 10),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      meal.title,
                      style: const TextStyle(color: Colors.white,fontSize: 20,fontWeight: FontWeight.w700),
                    ),
                    const SizedBox(height: 7,),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        MealItemObjectives(
                            icon: const Icon(
                              Icons.alarm,
                              color: Colors.white,
                              size: 15,
                            ),
                            text: meal.duration.toString()),
                        const SizedBox(
                          width: 20,
                        ),
                        MealItemObjectives(
                            icon: const Icon(
                              Icons.attach_money,
                              color: Colors.white,
                                 size: 15,
                            ),
                            text: affordabletext),
                        const SizedBox(
                          width: 20,
                        ),
                        MealItemObjectives(
                            icon: const Icon(
                              Icons.work,
                              color: Colors.white,
                                 size: 15,
                            ),
                            text: complexitytext),
                      ],
                    ),
                  ],
                ),
              ))
        ],
      ),
    );
  }
}
