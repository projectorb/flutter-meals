import 'package:flutter/material.dart';
import 'package:food_app/page/drawer/main_drawer.dart';

class Filter extends StatefulWidget {
  static const routeName = '/filters';
  final Function saveFilter;
  final Map<String, bool> currentFilter;

  Filter(this.currentFilter, this.saveFilter);

  @override
  _FilterState createState() => _FilterState();
}

class _FilterState extends State<Filter> {
  bool _glutenFree = false;
  bool _vegan = false;
  bool _vegetarian = false;
  bool _lactose = false;

  @override
  initState() {
    _glutenFree = widget.currentFilter['gluten'] as bool;
    _vegan = widget.currentFilter['vegan'] as bool;
    _vegetarian = widget.currentFilter['vegetarian'] as bool;
    _lactose = widget.currentFilter['lactose'] as bool;

    super.initState();
  }

  Widget _buildSwitch(
      String title, String subtitle, bool current, updateValue) {
    return SwitchListTile(
      title: Text(title),
      subtitle: Text(subtitle),
      value: current,
      onChanged: updateValue,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Filter'),
          actions: <Widget>[
            IconButton(
                onPressed: () {
                  final selectedFilter = {
                    'gluten': _glutenFree,
                    'lactose': _lactose,
                    'vegan': _vegan,
                    'vegetarian': _vegetarian,
                  };
                  widget.saveFilter(selectedFilter);
                },
                icon: Icon(Icons.save))
          ],
        ),
        drawer: MainDrawer(),
        body: Column(
          children: <Widget>[
            Container(
              padding: EdgeInsets.all(20),
              child: Text(
                'Adjustments',
                style: Theme.of(context).textTheme.headline6,
              ),
            ),
            Expanded(
              child: ListView(
                children: <Widget>[
                  _buildSwitch(
                    'Gluten-Free',
                    'Only include gluten-free meals',
                    _glutenFree,
                    (newValue) {
                      setState(
                        () {
                          _glutenFree = newValue;
                        },
                      );
                    },
                  ),
                  _buildSwitch(
                    'Lactose-Free',
                    'Only include lactose-free meals',
                    _lactose,
                    (newValue) {
                      setState(
                        () {
                          _lactose = newValue;
                        },
                      );
                    },
                  ),
                  _buildSwitch(
                    'Vegetarian',
                    'Only include Vegetarian meals',
                    _vegetarian,
                    (newValue) {
                      setState(
                        () {
                          _vegetarian = newValue;
                        },
                      );
                    },
                  ),
                  _buildSwitch(
                    'Vegan',
                    'Only include Vegan meals',
                    _vegan,
                    (newValue) {
                      setState(
                        () {
                          _vegan = newValue;
                        },
                      );
                    },
                  ),
                ],
              ),
            )
          ],
        ));
  }
}
