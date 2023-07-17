import 'package:flutter/material.dart';
import 'package:fridsch_app/bl/api/models/shopping_list.dart';

import '../../../../../../constants.dart';
import '../../shopping/shopping_screen.dart';

class ShoppingListRowTile extends StatelessWidget {
  const ShoppingListRowTile({
    Key? key,
    required this.shoppingList,
  }) : super(key: key);

  final ShoppingList shoppingList;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => ShoppingDetailScreen(list: shoppingList),
        ));
      },
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: kDefPadding / 2),
        //height: 195,
        width: 175,
        decoration: BoxDecoration(
          borderRadius: kDefBorderRadius,
          color: kOnBackgroundColour,
        ),
        child: Column(
          children: [
            const Spacer(flex: 2),
            Text(shoppingList.emoji, style: const TextStyle(fontSize: 40)),
            const Spacer(),
            Container(
              width: 175,
              padding:
                  const EdgeInsets.symmetric(horizontal: kDefPadding / 1.5),
              child: Text(
                '${shoppingList.name} • ${shoppingList.len ?? "…"}',
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
            const Spacer(flex: 2),
          ],
        ),
      ),
    );
  }
}
