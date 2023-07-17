import 'dart:convert';

List<Unit> unitFromJson(List json) =>
    List<Unit>.from(json.map((x) => Unit.fromJson(x)));

String unitToJson(List<Unit> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

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
