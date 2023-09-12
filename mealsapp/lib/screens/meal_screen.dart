import 'package:flutter/material.dart';
import 'package:mealsapp/model/meal.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mealsapp/providers/favouriteprovider.dart';

class MealScreen extends ConsumerWidget {
  const MealScreen(this.meal, this.setfavouritemeals, {super.key});

  final Meal meal;
  final void Function(Meal meal) setfavouritemeals;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        title: Text(meal.title),
        actions: [
          IconButton(
              onPressed: () {
                bool added = ref
                
                    .read(favouriteMealsProvider.notifier)
                    .togglemealfavourite(meal);
                ScaffoldMessenger.of(context).clearSnackBars();

                ScaffoldMessenger.of(context).showSnackBar(
                   SnackBar(duration: const Duration(seconds: 4),content: Text(added?'Meal added to favourites':'Meal removed from favourites'),)
                );
              },
              icon: AnimatedSwitcher(
                  duration: const Duration(milliseconds: 300),
                  transitionBuilder: (child, animation) {
                    return RotationTransition(
                        turns: Tween<double>(begin: 0.8, end: 1.0)
                            .animate(animation),
                        child: child);
                  },
                  child: ref.watch(favouriteMealsProvider).contains(meal)
                      ? const Icon(
                          Icons.star,
                          key: ValueKey(true),
                          size: 30,
                        )
                      : const Icon(
                          Icons.star_border,
                          key: ValueKey(false),
                          size: 30,
                        ))),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Image.network(
              meal.imageUrl,
              height: 300,
              fit: BoxFit.cover,
              width: double.infinity,
            ),
            const SizedBox(
              height: 30,
            ),
            Text(
              'Ingredients',
              style: TextStyle(
                  color: Theme.of(context).colorScheme.onSecondary,
                  fontSize: 20,
                  fontWeight: FontWeight.w700),
            ),
            for (final text in meal.ingredients)
              Container(
                margin: const EdgeInsets.symmetric(vertical: 10),
                child: Text(
                  text,
                  style: TextStyle(
                      color:
                          Theme.of(context).colorScheme.onSecondaryContainer),
                  textAlign: TextAlign.center,
                ),
              ),
            const SizedBox(
              height: 30,
            ),
            Text(
              'Steps',
              style: TextStyle(
                  color: Theme.of(context).colorScheme.onSecondary,
                  fontSize: 20,
                  fontWeight: FontWeight.w700),
            ),
            const SizedBox(
              height: 10,
            ),
            for (final text in meal.steps)
              Container(
                margin: const EdgeInsets.symmetric(vertical: 10),
                child: Text(
                  text,
                  style: TextStyle(
                      color:
                          Theme.of(context).colorScheme.onSecondaryContainer),
                  textAlign: TextAlign.center,
                ),
              )
          ],
        ),
      ),
    );
  }
}
