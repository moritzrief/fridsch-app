import 'package:flutter/material.dart';
import 'package:fridsch_app/bl/api/models/recipe.dart';
import 'package:fridsch_app/screens/main/screens/home/components/recipe_row_tille.dart';
import 'package:fridsch_app/screens/main/screens/home/components/storage/storage_row_tile.dart';

import '../../../../../../bl/api/models/storage.dart';

class RecipeRow extends StatelessWidget {
  const RecipeRow(
    this.recipes, {
    Key? key,
  }) : super(key: key);

  final List<Recipe> recipes;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      shrinkWrap: true,
      scrollDirection: Axis.horizontal,
      itemCount: recipes.length,
      itemBuilder: (context, index) =>
          RecipeRowTile(recipe: recipes[index]),
    );
  }
}