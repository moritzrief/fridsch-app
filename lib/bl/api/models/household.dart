import 'dart:convert';

List<Household> householdFromJson(List json) =>
    List<Household>.from(json.map((x) => Household.fromJson(x)));

String householdToJson(List<Household> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Household {
  Household({
    required this.id,
    required this.name,
    required this.emoji,
  });

  int id;
  String name;
  String emoji;
  bool admin = false;

  factory Household.fromJson(Map<String, dynamic> json) => Household(
        id: json["id"],
        name: json["name"],
        emoji: json["emoji"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "emoji": emoji,
      };
}
