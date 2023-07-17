import 'package:flutter/material.dart';
import 'package:fridsch_app/bl/api/household.service.dart';
import 'package:fridsch_app/bl/api/models/recipe.dart';
import 'package:fridsch_app/bl/api/recipe.service.dart';
import 'package:fridsch_app/bl/api/storage.service.dart';
import 'package:fridsch_app/screens/main/screens/home/components/loading_row.dart';
import 'package:fridsch_app/screens/main/screens/home/components/recipe_row.dart';
import 'package:fridsch_app/screens/main/screens/home/components/storage/storage_row.dart';
import 'package:fridsch_app/screens/main/screens/storage/add/add_storage_screen.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../../constants.dart';

class RecipeElement extends StatefulWidget {
  const RecipeElement({super.key});

  @override
  State<RecipeElement> createState() => _RecipeElementState();
}

class _RecipeElementState extends State<RecipeElement> {
  late Future<List<Recipe>> recipes;
  bool _isLoaded = false;

  @override
  void initState() {
    recipes = RecipeyService().getRecipes();
    recipes.whenComplete(() => setState(() => _isLoaded = true));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
            padding: const EdgeInsets.symmetric(horizontal: kDefPadding * 1.5),
            margin: const EdgeInsets.only(bottom: kDefPadding / 2),
            width: MediaQuery.of(context).size.width,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: const [
                Text('Recipes', style: TextStyle(fontSize: 17)),
              ],
            )),
        Container(
          height: 185,
          padding: const EdgeInsets.symmetric(horizontal: kDefPadding / 2),
          child: FutureBuilder(
              future: recipes,
              builder: (context, snapshot) => snapshot.hasData
                  ? RecipeRow(snapshot.data!)
                  : const LoadingRow()),
        ),
      ],
    );
  }
}
