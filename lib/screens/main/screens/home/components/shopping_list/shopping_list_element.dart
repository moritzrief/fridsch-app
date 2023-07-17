import 'package:flutter/material.dart';
import 'package:fridsch_app/bl/api/models/shopping_list.dart';
import 'package:fridsch_app/bl/api/shopping_list.service.dart';
import 'package:fridsch_app/screens/main/screens/home/components/loading_row.dart';
import 'package:fridsch_app/screens/main/screens/home/shopping/add/add_shopping_list_screen.dart';

import 'package:google_fonts/google_fonts.dart';

import '../../../../../../constants.dart';
import 'shopping_list_row_tile.dart';

class ShoppingListElement extends StatefulWidget {
  const ShoppingListElement({super.key});

  @override
  State<ShoppingListElement> createState() => _ShoppingListElementState();
}

class _ShoppingListElementState extends State<ShoppingListElement> {
  late final Future<List<ShoppingList>> shoppingLists;
  bool _isLoaded = false;

  @override
  void initState() {
    shoppingLists = ShoppingListService().getShoppingLists();
    shoppingLists.whenComplete(() {
      setState(() {
        _isLoaded = true;
      });
    });

    shoppingLists.then((value) => value.forEach((element) {
          element.getLength().whenComplete(() {
            setState(() {});
          });
        }));
    // int count = 0;
    // storages.then((value) => value.forEach((element) {
    //       element.getLength().whenComplete(() {
    //         if (++count == value.length) {
    //           setState(() => _isLoaded = true);
    //         }
    //       });
    //     }));
    super.initState();
  }

  addShoppingCallback(ShoppingList list) {
    setState(() {
      shoppingLists.then((value) => value.add(list));
    });
  }

  addShopping() {
    Navigator.of(context).push(MaterialPageRoute(
      builder: (context) => AddShoppingScreen(addShopping: addShoppingCallback),
    ));
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
            padding: const EdgeInsets.symmetric(horizontal: kDefPadding * 1.5),
            margin: const EdgeInsets.only(bottom: kDefPadding / 2),
            width: MediaQuery.of(context).size.width,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text('Shopping Lists', style: TextStyle(fontSize: 17)),
                TextButton(
                    onPressed: _isLoaded ? addShopping : null,
                    style: TextButton.styleFrom(
                      foregroundColor: kPrimaryColour,
                      backgroundColor: kPrimaryColour.withOpacity(.15),
                      shape: RoundedRectangleBorder(
                          borderRadius: kDefBorderRadius),
                    ),
                    child: Text(
                      '+ Add',
                      style: GoogleFonts.quicksand(fontWeight: FontWeight.w600),
                    ))
              ],
            )),
        Container(
          height: 185,
          padding: const EdgeInsets.symmetric(horizontal: kDefPadding / 2),
          child: FutureBuilder(
            future: shoppingLists,
            builder: (context, snapshot) => snapshot.hasData
                ? ListView.builder(
                    shrinkWrap: true,
                    scrollDirection: Axis.horizontal,
                    itemCount: snapshot.data!.length,
                    itemBuilder: (context, index) => ShoppingListRowTile(
                        shoppingList: snapshot.data![index]),
                  )
                : const LoadingRow(),
          ),
        ),
      ],
    );
  }
}
