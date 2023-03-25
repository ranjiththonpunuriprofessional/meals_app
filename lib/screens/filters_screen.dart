import 'package:flutter/material.dart';

import '../widgets/main_drawer.dart';


class FiltersScreen extends StatefulWidget {
  static const routeName = '/filters';

  final Function saveFilters;
  final Map<String ,bool>  currentFilter;

  FiltersScreen(this.saveFilters, this.currentFilter);

  @override
  State<FiltersScreen> createState() => _FiltersScreenState();
}

class _FiltersScreenState extends State<FiltersScreen> {
  bool _gluttenFree =false;
  bool _vegetarian =false;
  bool _vegan =false;
  bool _lactoseFree =false;                  

  @override
  void initState() {
     _gluttenFree =widget.currentFilter['gluten'] as bool;
     _lactoseFree =widget.currentFilter['lactose'] as bool;
     _vegetarian =widget.currentFilter['vegetarian'] as bool;
     _vegan =widget.currentFilter['vegan'] as bool;
    super.initState();
  }
 Widget _buildSwitchTile(
  String title,
  String description,
  bool currentValue, 
  Null Function(dynamic value) updateValue,
 ){
   return SwitchListTile(
            title: Text(title),
            value: currentValue, 
            subtitle: Text(description),
            onChanged: updateValue,
          );
 }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Your Filters'),
        actions: <Widget>[
          IconButton(
            onPressed: () => widget.saveFilters( {
              'gluten':_gluttenFree,
              'vegetarian':_vegetarian,
              'lactose':_lactoseFree,
              'vegan':_vegan,
            }), 
            icon: Icon(Icons.save)
          )
        ],
      ),
      drawer:MainDrawer(),
      body: Column(children:<Widget> [
          Container(
            padding: EdgeInsets.all(20),
            child: Text(
              'Adjust your selection',
              style: Theme.of(context).textTheme.titleLarge,
            ),
          ),
          Expanded(
            child: ListView(
              children: <Widget>[
                _buildSwitchTile(
                  'Gluten-free',
                  'Only include gluten-free meals',
                  _gluttenFree,
                   (value) {
                    setState(() {
                      _gluttenFree = value;
                    });
                  }  
                ),
                _buildSwitchTile(
                  'Vegetarian',
                  'Only include vegetarian meals',
                  _vegetarian,
                   (value) {
                    setState(() {
                      _vegetarian = value;
                    });
                  }  
                ),
                _buildSwitchTile(
                  'Vegan',
                  'Only include vegan meals',
                  _vegan,
                   (value) {
                    setState(() {
                      _vegan = value;
                    });
                  }  
                ),
                _buildSwitchTile(
                  'Lactose-free',
                  'Only include lactose-free meals',
                  _lactoseFree,
                   (value) {
                    setState(() {
                      _lactoseFree = value;
                    });
                  }  
                ),
              ],
            ),
          ),
        ],
      )
    );
  } 
}