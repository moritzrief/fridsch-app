import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../../bl/api/models/category.dart';
import '../../../../../bl/api/models/unit.dart';
import '../../../../../constants.dart';

class CategoryDropdown extends StatefulWidget {
  const CategoryDropdown({
    super.key,
    required this.categories,
    required this.changeCategory,
  });

  final List<Category> categories;
  final Function changeCategory;

  @override
  State<CategoryDropdown> createState() => _CategoryDropdownState();
}

class _CategoryDropdownState extends State<CategoryDropdown> {
  int? selectedValue;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        vertical: 4,
        horizontal: 8,
      ),
      decoration: BoxDecoration(
        borderRadius: kDefBorderRadius,
        color: kOnBackgroundColour,
      ),
      child: DropdownButton(
          value: selectedValue,
          icon: const Padding(
            padding: EdgeInsets.all(14),
            child: Icon(
              FontAwesomeIcons.chevronDown,
              size: 12,
            ),
          ),
          borderRadius: kDefBorderRadius,
          elevation: 1,
          dropdownColor: kOnBackgroundColour,
          iconEnabledColor: kDarkGreyContentColour,
          hint: const Text('Category'),
          underline: Container(),
          style: GoogleFonts.quicksand(
              fontSize: 18, color: kDarkGreyContentColour),
          items: widget.categories
              .map((e) => DropdownMenuItem(
                    value: e.id,
                    child: Text(
                      e.name,
                      textAlign: TextAlign.center,
                    ),
                  ))
              .toList(),
          onChanged: (value) {
            widget.changeCategory(widget.categories
                .where((element) => element.id == value!)
                .first);
            setState(() {
              selectedValue = value!;
            });
          }),
    );
  }
}

class UnitDropdown extends StatefulWidget {
  const UnitDropdown({
    super.key,
    required this.units,
    required this.changeUnit,
  });

  final List<Unit> units;
  final Function changeUnit;

  @override
  State<UnitDropdown> createState() => _UnitDropdownState();
}

class _UnitDropdownState extends State<UnitDropdown> {
  int? selectedValue;

  @override
  void initState() {
    //widget.units.add(Unit(id: 1, name: name, shortname: shortname));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        vertical: 4,
        horizontal: 8,
      ),
      decoration: BoxDecoration(
        borderRadius: kDefBorderRadius,
        color: kOnBackgroundColour,
      ),
      child: DropdownButton(
          value: selectedValue,
          icon: const Padding(
            padding: EdgeInsets.all(14),
            child: Icon(
              FontAwesomeIcons.chevronDown,
              size: 12,
            ),
          ),
          borderRadius: kDefBorderRadius,
          elevation: 1,
          dropdownColor: kOnBackgroundColour,
          iconEnabledColor: kDarkGreyContentColour,
          hint: const Text('Unit'),
          underline: Container(),
          style: GoogleFonts.quicksand(
              fontSize: 18, color: kDarkGreyContentColour),
          items: widget.units
              .map((e) => DropdownMenuItem(
                    value: e.id,
                    child: Text(
                      '${e.name} - ${e.shortname}',
                      textAlign: TextAlign.center,
                    ),
                  ))
              .toList(),
          onChanged: (value) {
            widget.changeUnit(
                widget.units.where((element) => element.id == value!).first);
            setState(() {
              selectedValue = value!;
            });
          }),
    );
  }
}
