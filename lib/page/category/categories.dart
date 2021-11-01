import 'package:flutter/material.dart';
import '../../model/dummy_data.dart';
import './item.dart';

class Categories extends StatelessWidget {
  const Categories({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GridView(
      padding: const EdgeInsets.all(25),
      gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
        maxCrossAxisExtent: 200,
        childAspectRatio: 3 / 2,
        crossAxisSpacing: 20,
        mainAxisSpacing: 20,
      ),
      children: <Widget>[
        ...DUMMY_CATEGORIES.map((category) {
          return CategoryItem(category.id, category.title, category.color);
        }).toList(),
      ],
    );
  }
}
