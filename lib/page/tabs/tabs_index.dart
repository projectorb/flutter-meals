import 'package:flutter/material.dart';
import 'package:food_app/model/meal.dart';
import 'package:food_app/page/category/categories.dart';
import 'package:food_app/page/category/favorite/main_favorite.dart';
import 'package:food_app/page/drawer/main_drawer.dart';

class TabsIndex extends StatefulWidget {
  final List<Meal> favorites;

  TabsIndex(this.favorites);

  @override
  _TabsIndexState createState() => _TabsIndexState();
}

class _TabsIndexState extends State<TabsIndex> {
  List<Map<String, Object>> _pages = [];

  int _selectedPageIndex = 0;

  void _selectPage(int index) {
    setState(() {
      _selectedPageIndex = index;
    });
  }

  @override
  void initState() {
    _pages = [
      {'page': Categories(), 'title': 'Categories'},
      {'page': Favorites(widget.favorites), 'title': 'Favorite'}
    ];
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_pages[_selectedPageIndex]['title'] as String),
      ),
      drawer: MainDrawer(),
      body: _pages[_selectedPageIndex]['page'] as Widget,
      bottomNavigationBar: BottomNavigationBar(
        onTap: _selectPage,
        backgroundColor: Theme.of(context).primaryColor,
        unselectedItemColor: Colors.white,
        selectedItemColor: Theme.of(context).accentColor,
        currentIndex: _selectedPageIndex,
        // type: BottomNavigationBarType.shifting,
        items: [
          BottomNavigationBarItem(
            backgroundColor: Theme.of(context).primaryColor,
            icon: Icon(Icons.category),
            label: 'Categories',
          ),
          BottomNavigationBarItem(
            backgroundColor: Theme.of(context).primaryColor,
            icon: Icon(Icons.star),
            label: 'Favorites',
          )
        ],
      ),
    );
  }
}
