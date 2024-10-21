import 'package:flutter/material.dart';
import 'package:meals/widgets/switch_filter.dart';

enum Filter{
  glutenFree,
  lactoseFree,
  vegetarian,
  vegan,
}

class FiltersScreen extends StatefulWidget {
  const FiltersScreen({super.key, required this.currentFilters});

  final Map<Filter, bool> currentFilters;

  @override
  State<FiltersScreen> createState() {
    return _FiltersScreenState();
  }
}

class _FiltersScreenState extends State<FiltersScreen> {
  var _glutenFreeFilterSet = false;
  var _lactoseFreeFilterSet = false;
  var _vegetarianFilterSet = false;
  var _veganFilterSet = false;

  @override
  void initState() {
    super.initState();

    _glutenFreeFilterSet= widget.currentFilters[Filter.glutenFree]!;
    _lactoseFreeFilterSet= widget.currentFilters[Filter.lactoseFree]!;
    _vegetarianFilterSet= widget.currentFilters[Filter.vegetarian]!;
    _veganFilterSet= widget.currentFilters[Filter.vegan]!;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Your Filters'),
      ),
      // drawer: MainDrawer(
      //   onSelectScreen: (identifier) {
      //     Navigator.pop(context);
      //     if (identifier == 'meal') {
      //       Navigator.pushReplacement(
      //         context,
      //         MaterialPageRoute(
      //           builder: (context) => const TabsScreen(),
      //         ),
      //       );
      //     }
      //   },
      // ),
      body: PopScope(
        canPop: false,

        onPopInvoked: (didPop) {
          if(didPop) return;
          Navigator.pop(
            context,
            {
              Filter.glutenFree: _glutenFreeFilterSet,
              Filter.lactoseFree: _lactoseFreeFilterSet,
              Filter.vegetarian: _vegetarianFilterSet,
              Filter.vegan: _veganFilterSet
            }
          );
        },
        child: Column(children: [
          SwitchFilter(
            title: 'Gluten-free',
            subtitle: 'Only include gluten-free meals.',
              isChecked: _glutenFreeFilterSet,
              changeSwitch: (onChanged) {
                setState(() {
                  _glutenFreeFilterSet = onChanged;
                });
              },),
          SwitchFilter(
            title: 'Lactose-free',
            subtitle: 'Only include lactose-freemeals.',
              isChecked: _lactoseFreeFilterSet,
              changeSwitch: (onChanged) {
                setState(() {
                  _lactoseFreeFilterSet = onChanged;
                });
              },),
          SwitchFilter(
            title: 'Vegetarian',
            subtitle: 'Only include vegetarian meals',
              isChecked: _vegetarianFilterSet,
              changeSwitch: (onChanged) {
                setState(() {
                  _vegetarianFilterSet = onChanged;
                });
              },),
          SwitchFilter(
            title: 'Vegan',
            subtitle: 'Only include vegan meals',
              isChecked: _veganFilterSet,
              changeSwitch: (onChanged) {
                setState(() {
                  _veganFilterSet = onChanged;
                });
              },),
        ]),
      ),
    );
  }
}
