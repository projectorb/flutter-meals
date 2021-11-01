import 'package:flutter/material.dart';
import 'package:food_app/model/dummy_data.dart';
import 'package:food_app/model/meal.dart';
import 'package:food_app/page/category/meal/detail.dart';
import 'package:food_app/page/filter/main_filter.dart';
import 'package:food_app/page/tabs/tabs_index.dart';
import 'page/category/list.dart';
import 'page/category/categories.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  // This widget is the root of your application.
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  Map<String, bool> _filters = {
    'gluten': false,
    'lactose': false,
    'vegan': false,
    'vegetarian': false,
  };

  List<Meal> _availableMeals = DUMMY_MEALS;

  void _setFilter(Map<String, bool> filterData) {
    setState(() {
      _filters = filterData;

      _availableMeals = DUMMY_MEALS.where((meal) {
        if (_filters['gluten']! && !meal.isGlutenFree) {
          return false;
        }

        if (_filters['lactose']! && !meal.isLactoseFree) {
          return false;
        }

        if (_filters['vegan']! && !meal.isVegan) {
          return false;
        }

        if (_filters['vegetarian']! && !meal.isVegetarian) {
          return false;
        }

        return true;
      }).toList();
    });
  }

  List<Meal> _favorites = [];
  void _toggleFavorite(String mealid) {
    final _existingIndex = _favorites.indexWhere((meal) => meal.id == mealid);
    if (_existingIndex >= 0) {
      setState(() {
        _favorites.removeAt(_existingIndex);
      });
    } else {
      setState(() {
        _favorites.add(DUMMY_MEALS.firstWhere((meal) => meal.id == mealid));
      });
    }
  }

  bool _isMealFavorite(String id) {
    return _favorites.any((meal) => meal.id == id);
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Pinoy Foods',
      theme: ThemeData(
        primarySwatch: Colors.pink,
        accentColor: Colors.amber,
        canvasColor: Color.fromRGBO(255, 254, 229, 1),
        fontFamily: 'Raleway',
        textTheme: ThemeData.light().textTheme.copyWith(
            bodyText1: TextStyle(
              color: Color.fromRGBO(20, 51, 51, 1),
            ),
            bodyText2: TextStyle(
              color: Color.fromRGBO(20, 51, 51, 1),
            ),
            headline6: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              fontFamily: 'RobotoCondensed',
            )),
      ),
      initialRoute: '/',
      routes: {
        '/': (c) => TabsIndex(_favorites),
        CategoryList.routeName: (ctx) => CategoryList(_availableMeals),
        MealDetail.routeName: (ctx) =>
            MealDetail(_toggleFavorite, _isMealFavorite),
        Filter.routeName: (ctx) => Filter(_filters, _setFilter),
      },
      onGenerateRoute: (setting) {
        print(setting.arguments);
        return MaterialPageRoute(
          builder: (ctx) {
            return Categories();
          },
        );
      },
      onUnknownRoute: (setting) {
        return MaterialPageRoute(builder: (context) {
          // 404 not found
          return Categories();
        });
      },
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Scaffold(),
    );
  }
}
