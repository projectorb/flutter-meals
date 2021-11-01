import 'package:flutter/material.dart';
import 'package:food_app/model/dummy_data.dart';

class MealDetail extends StatelessWidget {
  static const routeName = '/meal/detail';

  final Function toggleFavorite;
  final Function isFavorite;

  MealDetail(this.toggleFavorite, this.isFavorite);

  Widget sectionTitle(BuildContext context, String text) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10),
      child: Text(
        text,
        style: Theme.of(context).textTheme.headline6,
      ),
    );
  }

  Widget buildContainer(Widget child) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(
          color: Colors.grey,
        ),
        borderRadius: BorderRadius.circular(10),
      ),
      margin: EdgeInsets.all(10),
      padding: EdgeInsets.all(10),
      height: 200,
      width: 300,
      child: child,
    );
  }

  @override
  Widget build(BuildContext context) {
    final mealId =
        ModalRoute.of(context)!.settings.arguments as Map<String, String>;
    final selectedMeal =
        DUMMY_MEALS.firstWhere((meal) => meal.id == mealId['id']);
    return Scaffold(
      appBar: AppBar(
        title: Text('${selectedMeal.title}'),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Container(
              height: 300,
              width: double.infinity,
              child: Image.network(
                selectedMeal.imageUrl,
                fit: BoxFit.cover,
              ),
            ),
            sectionTitle(context, 'Ingredients'),
            buildContainer(
              ListView.builder(
                itemBuilder: (ctx, index) => Card(
                  color: Theme.of(context).accentColor,
                  child: Padding(
                    padding: EdgeInsets.symmetric(
                      vertical: 10,
                      horizontal: 20,
                    ),
                    child: Text(
                      selectedMeal.ingredients[index],
                    ),
                  ),
                ),
                itemCount: selectedMeal.ingredients.length,
              ),
            ),
            sectionTitle(context, 'Steps'),
            buildContainer(ListView.builder(
              itemBuilder: (ctx, index) => Column(children: <Widget>[
                ListTile(
                  leading: CircleAvatar(
                    child: Text('# ${index + 1}'),
                  ),
                  title: Text(selectedMeal.steps[index]),
                ),
                Divider()
              ]),
              itemCount: selectedMeal.steps.length,
            ))
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(isFavorite(mealId['id']) ? Icons.star : Icons.star_border),
        onPressed: () => toggleFavorite(mealId['id']),
      ),
    );
  }
}
