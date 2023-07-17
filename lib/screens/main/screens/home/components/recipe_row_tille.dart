import 'package:flutter/material.dart';
import 'package:fridsch_app/bl/api/models/recipe.dart';

import '../../../../../../constants.dart';

class RecipeRowTile extends StatelessWidget {
  const RecipeRowTile({
    Key? key,
    required this.recipe,
  }) : super(key: key);

  final Recipe recipe;

  @override
  Widget build(BuildContext context) {
    onTap() {
      Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => RecipeDetailScreen(recipe: recipe)));
    }

    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: kDefPadding / 2),
        //height: 195,
        width: 175,
        decoration: BoxDecoration(
          borderRadius: kDefBorderRadius,
          color: kOnBackgroundColour,
        ),
        child: Column(
          children: [
            const Spacer(flex: 2),
            Text('🗒️', style: const TextStyle(fontSize: 40)),
            const Spacer(),
            Container(
                width: double.infinity,
                padding: const EdgeInsets.only(left: kDefPadding),
                child: Text(recipe.name, style: const TextStyle(fontSize: 18))),
            const Spacer(),
          ],
        ),
      ),
    );
  }
}

class RecipeDetailScreen extends StatelessWidget {
  const RecipeDetailScreen({super.key, required this.recipe});

  final Recipe recipe;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kBackgroundColour,
      body: SafeArea(
        child: Column(
          children: [
            Text('Recipe Ingredients: ', style: const TextStyle(fontSize: 20)),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(kDefPadding * 2),
                child: ListView.builder(
                  itemBuilder: (context, index) =>
                      Text('- ' + recipe.ingredients[index].name),
                  itemCount: recipe.ingredients.length,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
