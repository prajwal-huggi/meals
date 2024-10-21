import 'package:flutter/material.dart';
import 'package:meals/data/dummy_data.dart';
import 'package:meals/models/meal.dart';
import 'package:meals/screens/categories_screen.dart';
import 'package:meals/screens/filters_screen.dart';
import 'package:meals/screens/meals_screen.dart';
import 'package:meals/widgets/main_drawer.dart';

//k is used for the global variables as the standard notation
const kInitialFilters={
  Filter.glutenFree: false,
    Filter.lactoseFree: false,
    Filter.vegetarian: false,
    Filter.vegan: false,
};

class TabsScreen extends StatefulWidget {
  const TabsScreen({super.key});

  @override
  State<TabsScreen> createState() {
    return _TabsScreenState();
  }
}

class _TabsScreenState extends State<TabsScreen> {
  int _selectedPageIndex = 0;
  final List<Meal> _favouriteMeals = [];
  Map<Filter, bool> _selectedFilter= kInitialFilters;

  void _showInfoMessage(String message){
    ScaffoldMessenger.of(context).clearSnackBars();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message)),
    );
  }

  void _toggleMealFavoriteStatus(Meal meal) {
    final isExisting = _favouriteMeals.contains(meal);

    if (isExisting) {
      setState(() {
        _favouriteMeals.remove(meal);
        _showInfoMessage("Item removed Successfully");
      });
    } else {
      setState(() {
        _favouriteMeals.add(meal);
        _showInfoMessage("Item added Successfully");
      });
    }
  }

  void _selectPage(int index) {
    setState(() {
      _selectedPageIndex = index;
    });
  }

  void _setScreen(String identifier)async{
    Navigator.pop(context);
    if(identifier== 'filters'){
      final result= await Navigator.push<Map<Filter, bool>>(
        context,
        MaterialPageRoute(builder: (context)=> FiltersScreen(currentFilters: _selectedFilter,))
      );

      setState((){
        //if the result is null then use the kInitialFilters
        _selectedFilter= result ?? kInitialFilters;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final availableMeals= dummyMeals.where((meal){
      if(_selectedFilter[Filter.glutenFree]! && !meal.isGlutenFree){
        return false;
      }
      if(_selectedFilter[Filter.lactoseFree]! && !meal.isLactoseFree){
        return false;
      }
      if(_selectedFilter[Filter.vegetarian]! && !meal.isVegetarian){
        return false;
      }
      if(_selectedFilter[Filter.vegan]! && !meal.isVegan){
        return false;
      }
      return true; 
    }).toList();


    Widget activePage = CategoriesScreen(
      onToggleFavorite: _toggleMealFavoriteStatus,
      availableMeals: availableMeals,
    );
    var activePageTitle = 'Categories';

    if (_selectedPageIndex == 1) {
      activePage = MealsScreen(
        meals: _favouriteMeals,
        onToggleFavorite: _toggleMealFavoriteStatus,
      );
      activePageTitle = 'Your Favourites';
    }
    return Scaffold(
      appBar: AppBar(
        title: Text(activePageTitle),
      ),
      drawer: MainDrawer(onSelectScreen: _setScreen),
      body: activePage,
      bottomNavigationBar: BottomNavigationBar(
        onTap: _selectPage,
        currentIndex: _selectedPageIndex,
        items: const [
          BottomNavigationBarItem(
              icon: Icon(Icons.set_meal), label: 'Categories'),
          BottomNavigationBarItem(icon: Icon(Icons.star), label: 'Favourites')
        ],
      ),
    );
  }
}
