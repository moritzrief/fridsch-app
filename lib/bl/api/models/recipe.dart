// To parse this JSON data, do
//
//     final recipe = recipeFromJson(jsonString);

import 'dart:convert';

List<Recipe> recipeFromJson(List json) =>
    List<Recipe>.from(json.map((x) => Recipe.fromJson(x)));

String recipeToJson(List<Recipe> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Recipe {
  Recipe({
    required this.id,
    required this.name,
    required this.ingredients,
  });

  int id;
  String name;
  List<Ingredient> ingredients;

  factory Recipe.fromJson(Map<String, dynamic> json) => Recipe(
        id: json["id"],
        name: json["name"],
        ingredients: List<Ingredient>.from(
            json["ingredients"].map((x) => Ingredient.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "ingredients": List<dynamic>.from(ingredients.map((x) => x.toJson())),
      };
}

class Ingredient {
  Ingredient({
    required this.id,
    required this.name,
    required this.standardUnitAmount,
    required this.unit,
    required this.category,
  });

  int id;
  String name;
  int standardUnitAmount;
  Unit unit;
  Category category;

  factory Ingredient.fromJson(Map<String, dynamic> json) => Ingredient(
        id: json["id"],
        name: json["name"],
        standardUnitAmount: json["standardUnitAmount"],
        unit: Unit.fromJson(json["unit"]),
        category: Category.fromJson(json["category"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "standardUnitAmount": standardUnitAmount,
        "unit": unit.toJson(),
        "category": category.toJson(),
      };
}

class Category {
  Category({
    required this.id,
    required this.name,
  });

  int id;
  String name;

  factory Category.fromJson(Map<String, dynamic> json) => Category(
        id: json["id"],
        name: json["name"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
      };
}

class Unit {
  Unit({
    required this.id,
    required this.name,
    required this.shortname,
  });

  int id;
  String name;
  String shortname;

  factory Unit.fromJson(Map<String, dynamic> json) => Unit(
        id: json["id"],
        name: json["name"],
        shortname: json["shortname"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "shortname": shortname,
      };
}
