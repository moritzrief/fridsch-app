import 'dart:convert';

import 'package:fridsch_app/bl/api/storage.service.dart';

List<Storage> storageFromJson(List json) =>
    List<Storage>.from(json.map((x) => Storage.fromJson(x)));

String storageToJson(List<Storage> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Storage {
  Storage({
    required this.householdId,
    required this.name,
    required this.emoji,
  });

  int householdId;
  String name;
  String emoji;
  int? len;

  factory Storage.fromJson(Map<String, dynamic> json) => Storage(
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
    len = await StorageService().getLength(this);
  }
}
