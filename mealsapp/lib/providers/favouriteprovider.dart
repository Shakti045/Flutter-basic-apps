import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mealsapp/model/meal.dart';

class FavouriteMealsNotifier extends StateNotifier<List<Meal>> {
  FavouriteMealsNotifier() : super([]);

  bool togglemealfavourite(Meal meal) {
    bool isadded = state.contains(meal);
    if (isadded) {
      state =
          state.where((previousmeal) => previousmeal.id != meal.id).toList();
      return false;
    } else {
      state = [...state, meal];
      return true;
    }
  }
}

final favouriteMealsProvider =
    StateNotifierProvider<FavouriteMealsNotifier, List<Meal>>(
        (ref) => FavouriteMealsNotifier());
