import 'dart:convert';

List<Item> itemFromJson(List json) =>
    List<Item>.from(json.map((x) => Item.fromJson(x)));

String itemToJson(List<Item> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Item {
  Item({
    required this.id,
    required this.name,
    required this.standardUnitAmount,
  });

  int id;
  String name;
  double standardUnitAmount;

  factory Item.fromJson(Map<String, dynamic> json) => Item(
        id: json["id"],
        name: json["name"],
        standardUnitAmount:
            double.tryParse(json["standardUnitAmount"].toString()) ?? 1,
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "standardUnitAmount": standardUnitAmount,
      };

  @override
  String toString() => name;

  @override
  int get hashCode => id.hashCode + name.hashCode + standardUnitAmount.hashCode;

  @override
  bool operator ==(Object other) =>
      other is Item && other.runtimeType == runtimeType && other.id == id;
}
