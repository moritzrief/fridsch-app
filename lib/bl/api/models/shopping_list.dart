// To parse this JSON data, do
//
//     final shoppingList = shoppingListFromJson(jsonString);

import 'dart:convert';

import 'package:fridsch_app/bl/api/shopping_list.service.dart';

List<ShoppingList> shoppingListFromJson(List json) =>
    List<ShoppingList>.from(json.map((x) => ShoppingList.fromJson(x)));

String shoppingListToJson(List<ShoppingList> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class ShoppingList {
  ShoppingList({
    required this.householdId,
    required this.name,
    required this.emoji,
  });

  int householdId;
  String name;
  String emoji;
  int? len;

  factory ShoppingList.fromJson(Map<String, dynamic> json) => ShoppingList(
        householdId: json["household_id"],
        name: json["name"],
        emoji: json["emoji"],
      );

  Map<String, dynamic> toJson() => {
        "household_id": householdId,
        "name": name,
        "emoji": emoji,
      };

  Future<void> getLength() async {
    len = await ShoppingListService().getLength(this);
  }

  Future<bool> finish(String saveToStorage) {
    return ShoppingListService().finish(householdId, name, saveToStorage);
  }
}
