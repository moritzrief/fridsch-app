import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:fridsch_app/constants.dart';

List<Category> categoryFromJson(List json) =>
    List<Category>.from(json.map((x) => Category.fromJson(x)));

String categoryToJson(List<Category> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

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

  FaIcon getIcon() {
    switch (id) {
      case -1:
        return const FaIcon(
          FontAwesomeIcons.ghost,
          color: kDarkGreyContentColour,
        );
      case 1:
        return const FaIcon(
          FontAwesomeIcons.appleWhole,
          color: Color(0xffff595e),
        );
      case 2:
        return const FaIcon(
          FontAwesomeIcons.carrot,
          color: Color(0xff52b788),
        );
      case 3:
        return const FaIcon(
          FontAwesomeIcons.drumstickBite,
          color: Color(0xffff5d8f),
        );
      case 4:
        return const FaIcon(
          FontAwesomeIcons.fish,
          color: Color(0xff00a6fb),
        );
      case 5:
        return const FaIcon(
          FontAwesomeIcons.wheatAwn,
          color: Color(0xffe7bc91),
        );
      default:
        return const FaIcon(
          FontAwesomeIcons.solidCircleQuestion,
          color: kDarkGreyContentColour,
        );
    }
  }
}
