import 'package:flutter/material.dart';
import 'package:food_app/model/meal.dart';
import 'package:food_app/page/category/meal/meal_list.dart';

class Favorites extends StatelessWidget {
  final List<Meal> favorites;

  Favorites(this.favorites);

  @override
  Widget build(BuildContext context) {
    if (favorites.isEmpty) {
      return Center(
        child: Text('You have no favorites yet - start adding some!'),
      );
    } else {
      return ListView.builder(
        itemBuilder: (ctx, index) {
          var meal = favorites[index];
          return MealList(
              id: meal.id,
              title: meal.title,
              affordability: meal.affordability,
              complexity: meal.complexity,
              duration: meal.duration,
              imageUrl: meal.imageUrl);
        },
        itemCount: favorites.length,
      );
    }
  }
}
