import 'package:flutter/material.dart';
import 'package:meals/models/meal.dart';
import 'package:meals/widgets/meal_item_trait.dart';
import 'package:transparent_image/transparent_image.dart';

class MealItem extends StatelessWidget {
  const MealItem({super.key, required this.meal, required this.onSelectMeal});

  final Meal meal;
  final void Function(Meal meal) onSelectMeal;

  String get complexityText{
    return meal.complexity.name[0].toUpperCase()+ meal.complexity.name.substring(1);
  }
  String get affordabilityText{
    return meal.affordability.name[0].toUpperCase()+ meal.affordability.name.substring(1);
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.all(8),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      //clipBehavior is used because the stack doesn't allow the radius to be
      //in circular so to enforce it clipBhehavior is used.
      //It actually do is that it crops the part of the image which goes beyond
      //the shape
      clipBehavior: Clip.hardEdge,
      //Elevation is used to give the 3d look to the card
      elevation: 2,
      child: InkWell(
        onTap: (){onSelectMeal(meal);},
        child: Stack(
          children: [
            FadeInImage(
              placeholder: MemoryImage(kTransparentImage),
              image: NetworkImage(meal.imageUrl),
              fit: BoxFit.cover,
              height: 200,
              width: double.infinity
            ),
            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: Container(
                padding:
                    const EdgeInsets.symmetric(vertical: 5, horizontal: 44),
                color: Colors.black45,
                child: Column(
                  children: [
                  Text(meal.title,
                      maxLines: 2,
                      textAlign: TextAlign.center,
                      softWrap: true,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.white)),
                  const SizedBox(height: 12),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children:[
                      MealItemTrait(icon: Icons.schedule, label: meal.duration.toString()),
                      const SizedBox(width: 12),
                      MealItemTrait(icon: Icons.work, label: complexityText),
                      const SizedBox(width: 12),
                      MealItemTrait(icon: Icons.money, label: affordabilityText)
                    ],
                  ),
                ]),
              ),
            )
          ],
        ),
      ),
    );
  }
}
