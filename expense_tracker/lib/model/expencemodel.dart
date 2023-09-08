import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:uuid/uuid.dart';

enum Category { food, travel, leisure, work }

final formatter = DateFormat.yMd();
const uuid = Uuid();

final Map<String, Icon> categoryicons = {
  Category.food.toString(): const Icon(Icons.dining),
  Category.leisure.toString(): const Icon(Icons.card_travel),
  Category.work.toString(): const Icon(Icons.work),
  Category.travel.toString(): const Icon(Icons.flight_takeoff),
};

class Expence {
  final String title;
  final double amount;
  final String createdat;
  final Category category;
  final String id;
  Expence({required this.title, required this.amount, required this.category})
      : id = uuid.v4(),
        createdat = formatter.format(DateTime.now());

    Icon get categoryIcon {
    return categoryicons[category.toString()]!;
  }
}
