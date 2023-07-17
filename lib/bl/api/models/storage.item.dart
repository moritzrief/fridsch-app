// To parse this JSON data, do
//
//     final storageItem = storageItemFromJson(jsonString);

import 'dart:convert';
import 'category.dart';
import 'item.dart';
import 'unit.dart';

List<StorageItem> storageItemFromJson(List json) =>
    List<StorageItem>.from(json.map((x) => StorageItem.fromJson(x)));

String storageItemToJson(List<StorageItem> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class StorageItem {
  StorageItem({
    required this.itemId,
    required this.householdId,
    required this.storageName,
    required this.quantity,
    required this.createdAt,
    this.removedAt,
    required this.item,
    required this.unit,
    required this.category,
  });

  int itemId;
  int householdId;
  String storageName;
  double quantity;
  DateTime createdAt;
  DateTime? removedAt;
  Item item;
  Unit unit;
  Category category;

  factory StorageItem.fromJson(Map<String, dynamic> json) => StorageItem(
        itemId: json["item_id"],
        householdId: json["household_id"],
        storageName: json["storage_name"],
        quantity: double.parse(json["quantity"].toString()),
        createdAt: DateTime.tryParse(json["created_at"]) ?? DateTime.now(),
        removedAt: DateTime.tryParse(json["removed_at"] ?? ''),
        item: Item.fromJson(json["item"]),
        unit: Unit.fromJson(json["unit"]),
        category: Category.fromJson(json["category"]),
      );

  Map<String, dynamic> toJson() => {
        "item_id": itemId,
        "household_id": householdId,
        "storage_name": storageName,
        "quantity": quantity,
        "created_at": createdAt.toIso8601String(),
        "removed_at": removedAt,
        "item": item.toJson(),
        "unit": unit.toJson(),
        "category": category.toJson(),
      };
}
