import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:fridsch_app/bl/api/category.service.dart';
import 'package:fridsch_app/bl/api/household.service.dart';
import 'package:fridsch_app/bl/api/item.service.dart';
import 'package:fridsch_app/bl/api/models/category.dart';
import 'package:fridsch_app/bl/api/models/item.dart';
import 'package:fridsch_app/bl/api/models/shoppinglistitem.dart';
import 'package:fridsch_app/bl/api/models/storage.item.dart';
import 'package:fridsch_app/bl/api/models/unit.dart';
import 'package:fridsch_app/constants.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../../../bl/api/unit.service.dart';
import '../../../storage/components/amount_input.dart';
import '../../../storage/components/dropwdowns.dart';

class AddShoppingItemScreen extends StatelessWidget {
  AddShoppingItemScreen({super.key, required this.addItem});

  final Function addItem;

  Unit? unit;
  Item? item;

  unitChangeCallback(Unit unit) {
    print(unit.name);
    this.unit = unit;
  }

  itemChangeCallback(Item item) {
    print(item.name);
    this.item = item;
  }

  final quantityController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kBackgroundColour,
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(
              horizontal: MediaQuery.of(context).size.width * .075),
          child: Column(
            children: [
              SizedBox(
                width: double.infinity,
                child: Text(
                  'Add Item',
                  textAlign: TextAlign.center,
                  style: GoogleFonts.quicksand(fontSize: 28),
                ),
              ),
              const SizedBox(height: kDefPadding * 2),
              ItemChooser(callback: itemChangeCallback),
              const SizedBox(height: kDefPadding / 2),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SizedBox(
                    width: MediaQuery.of(context).size.width * .4,
                    child: NumberInput(
                        controller: quantityController,
                        icon: FontAwesomeIcons.weightHanging,
                        hint: 'Unit Amount'),
                  ),
                  FutureBuilder(
                    builder: (context, snapshot) => snapshot.hasData
                        ? UnitDropdown(
                            units: snapshot.data!,
                            changeUnit: unitChangeCallback)
                        : Container(),
                    future: UnitService().getUnits(),
                  ),
                ],
              ),
              const SizedBox(height: kDefPadding),
              TextButton(
                onPressed: () async {
                  if (item == null || unit == null) {
                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                      content: Text(
                        'No field must be empty!',
                        style: GoogleFonts.nunito(
                          color: kDarkGreyContentColour,
                          fontWeight: FontWeight.w600,
                          fontSize: 16,
                        ),
                      ),
                      behavior: SnackBarBehavior.floating,
                      backgroundColor: kOnBackgroundColour,
                      shape: RoundedRectangleBorder(
                          borderRadius: kDefBorderRadius),
                    ));
                    return;
                  }

                  if (item!.id == -2) {
                    item!.standardUnitAmount =
                        double.tryParse(quantityController.text) ?? 1;
                    item = await ItemService().createItem(
                        item!, unit!, Category(id: 1, name: 'asdf'));
                  }

                  addItem(
                    ShoppingListItem(
                      itemId: item!.id,
                      householdId: HouseholdService().currentHousehold,
                      fridgeName: 'asdf',
                      quantity: double.tryParse(quantityController.text) ?? 1,
                      item: item!,
                      unit: unit!,
                      isDone: false,
                    ),
                  );
                  Navigator.pop(context);
                },
                style: TextButton.styleFrom(
                  shape: RoundedRectangleBorder(borderRadius: kDefBorderRadius),
                  fixedSize:
                      Size(MediaQuery.of(context).size.width * 325 / 375, 58),
                  backgroundColor: kOnBackgroundColour,
                  foregroundColor: kDarkContentColour,
                ),
                child: Text(
                  '+ Add',
                  style: GoogleFonts.quicksand(
                      fontSize: 16, fontWeight: FontWeight.w600),
                ),
              ),
              const Spacer(),
            ],
          ),
        ),
      ),
    );
  }
}

class ItemChooser extends StatefulWidget {
  const ItemChooser({
    super.key,
    required this.callback,
  });

  final Function callback;

  @override
  State<ItemChooser> createState() => _ItemChooserState();
}

class _ItemChooserState extends State<ItemChooser> {
  late Future<List<Item>> itemList;

  @override
  void initState() {
    itemList = ItemService().getItems(HouseholdService().currentHousehold);
    super.initState();
  }

  String helper = '';

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 50,
      child: FutureBuilder(
        builder: (context, snapshot) => snapshot.hasData
            ? Autocomplete<Item>(
                fieldViewBuilder: (context, textEditingController, focusNode,
                        onFieldSubmitted) =>
                    TextField(
                  controller: textEditingController,
                  focusNode: focusNode,
                  onSubmitted: (_) => onFieldSubmitted(),
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: kOnBackgroundColour,
                    hintText: 'Choose Item',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15),
                      borderSide: BorderSide.none,
                    ),
                  ),
                ),
                optionsBuilder: (textEditingValue) {
                  helper = textEditingValue.text;
                  final List<Item> tmp =
                      List.from(snapshot.data!, growable: true);
                  tmp.removeWhere((element) => !element.name
                      .toLowerCase()
                      .contains(textEditingValue.text.toLowerCase()));
                  if (!tmp.any((element) =>
                      element.name.toLowerCase() ==
                      textEditingValue.text.toLowerCase())) {
                    tmp.add(Item(id: -2, name: '+ Add', standardUnitAmount: 1));
                  }
                  return tmp;
                },
                onSelected: (option) => {
                  option.name = option.id == -2 ? helper : option.name,
                  widget.callback(option)
                },
              )
            : Container(),
        future: itemList,
      ),
    );
  }
}
