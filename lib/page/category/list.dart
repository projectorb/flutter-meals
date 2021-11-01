import 'package:flutter/material.dart';
import 'package:food_app/page/category/meal/meal_list.dart';
import '../../model/meal.dart';

class CategoryList extends StatefulWidget {
  static const routeName = '/category/detail';
  final List<Meal> availableMeals;

  CategoryList(this.availableMeals);
  @override
  _CategoryListState createState() => _CategoryListState();
}

class _CategoryListState extends State<CategoryList> {
  String title = '';
  List categoryMeal = [];
  var _loaded = false;

  @override
  void didChangeDependencies() {
    if (!_loaded) {
      final routeArgs =
          ModalRoute.of(context)!.settings.arguments as Map<String, Object>;
      title = routeArgs['title'] as String;
      final id = routeArgs['id'];
      categoryMeal = widget.availableMeals.where((meal) {
        return meal.categories.contains(id);
      }).toList();
      _loaded = true;
    }
    super.didChangeDependencies();
  }

  void _removeMeal(String mealid) {
    setState(() {
      categoryMeal.removeWhere((meal) => meal.id == mealid);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
      ),
      body: ListView.builder(
        itemBuilder: (ctx, index) {
          var meal = categoryMeal[index];
          return MealList(
              id: meal.id,
              title: meal.title,
              affordability: meal.affordability,
              complexity: meal.complexity,
              duration: meal.duration,
              imageUrl: meal.imageUrl);
        },
        itemCount: categoryMeal.length,
      ),
    );
  }
}
