import 'dart:convert';

import 'unit.dart';

import 'item.dart';

List<ShoppingListItem> shoppingListItemFromJson(List json) =>
    List<ShoppingListItem>.from(json.map((x) => ShoppingListItem.fromJson(x)));

List<ShoppingListItem> shoppingListItemFromIncompleteJson(List json) =>
    List<ShoppingListItem>.from(
        json.map((x) => ShoppingListItem.fromIncompleteJson(x)));

String shoppingListItemToJson(List<ShoppingListItem> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class ShoppingListItem {
  ShoppingListItem({
    required this.itemId,
    required this.householdId,
    required this.fridgeName,
    required this.quantity,
    required this.isDone,
    required this.item,
    required this.unit,
  });

  int itemId;
  int householdId;
  String fridgeName;
  double quantity;
  bool isDone;
  Item item;
  Unit unit;

  factory ShoppingListItem.fromJson(Map<String, dynamic> json) =>
      ShoppingListItem(
        itemId: json["item_id"],
        householdId: json["household_id"],
        fridgeName: json["fridge_name"],
        quantity: double.tryParse(["quantity"].toString()) ?? 1,
        isDone: json["isDone"],
        item: Item.fromJson(json["item"]),
        unit: Unit.fromJson(json["unit"]),
      );

  factory ShoppingListItem.fromIncompleteJson(Map<String, dynamic> json) =>
      ShoppingListItem(
          itemId: json["item_id"],
          householdId: json["household_id"],
          fridgeName: json["fridge_name"],
          quantity: double.tryParse(["quantity"].toString()) ?? 1,
          isDone: json["isDone"],
          item: Item.fromJson(json["item"] ??
              Item(id: json["item_id"], name: 'name', standardUnitAmount: 1)
                  .toJson()),
          unit: Unit.fromJson(json["unit"] ??
              Unit(id: 1, name: 'kilogram', shortname: 'kg').toJson()));

  Map<String, dynamic> toJson() => {
        "item_id": itemId,
        "household_id": householdId,
        "fridge_name": fridgeName,
        "quantity": quantity,
        "isDone": isDone,
        "item": item.toJson(),
        "unit": unit.toJson(),
      };
}
