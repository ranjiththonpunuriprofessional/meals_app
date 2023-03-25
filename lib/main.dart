
import 'package:flutter/material.dart';

import './dummy_data.dart';
import './models/meal.dart';
import './screens/filters_screen.dart';
import './screens/tabs_screen.dart';
import './screens/meal_detail_screen.dart';
import './screens/category_meals_screen.dart';
import './screens/categories_screen.dart';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
   Map<String, bool> _filters = {
    'gluten':false,
    'vegetarian':false,
    'lactose':false,
    'vegan':false,
   };

  List<Meal> _availableMeals = DUMMY_MEALS;
  List<Meal> _favorateMeals = [];

  void _setFilters( Map<String, bool> filterData){
    setState(() {
      _filters = filterData;
      _availableMeals = DUMMY_MEALS.where((meal) {
        if(_filters['gluten'] as bool && !meal.isGlutenFree){
          return false;
        }
         if(_filters['vegetarian'] as bool && !meal.isVegetarian){
          return false;
        }
         if(_filters['lactose'] as bool && !meal.isLactoseFree){
          return false;
        }
         if(_filters['vegan'] as bool && !meal.isVegan){
          return false;
        }
        return true;
      }).toList();
    });
  }

  void _toggleFavorite(String mealId){
    final existingIndex = _favorateMeals.indexWhere((meal)=>meal.id == mealId);
    if(existingIndex >= 0){
      setState(() {
        _favorateMeals.removeAt(existingIndex);
      });
    }else{
       setState(() {
        _favorateMeals.add(DUMMY_MEALS.firstWhere((meal) => meal.id==mealId));
      });
    }
  }

  bool _isMealFavorite(String mealId){
    return _favorateMeals.any((meal)=>meal.id == mealId);
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'DeliMeals',
      theme: ThemeData(
        primarySwatch: Colors.pink,
        accentColor: Colors.amber,
        canvasColor: Color.fromRGBO(255,254,229,1),
        fontFamily: 'Raleway',
        textTheme: ThemeData.light().textTheme.copyWith(
            bodyLarge: TextStyle(
              color: Color.fromRGBO(20, 51, 51, 1)
            ),
            bodyMedium:  TextStyle(
              color: Color.fromRGBO(20, 51, 51, 1)
            ),
            titleLarge: TextStyle(
              fontSize: 20,
              fontFamily: 'RobotoCondensed',
              fontWeight: FontWeight.bold
            )
        ),
      ),
      //home: CategoriesScreen(),
      initialRoute: '/',
      routes: {
        '/':(ctx)=> TabsScreen(_favorateMeals),
        CategoryMealsScreen.routeName:(ctx)=> CategoryMealsScreen(_availableMeals),
        MealDetailScreen.routeName: (ctx)=> MealDetailScreen(_toggleFavorite,_isMealFavorite),
        FiltersScreen.routeName:(ctx)=>FiltersScreen(_setFilters,_filters)
      },
      // onGenerateRoute: (settings){
      //   print(settings.arguments);
      //   return MaterialPageRoute(builder: (ctx)=>CategoriesScreen());
      // },
      // onUnknownRoute: (settings){
      //   return  MaterialPageRoute(builder: (ctx)=>CategoriesScreen());
      // },
    );
  }
}