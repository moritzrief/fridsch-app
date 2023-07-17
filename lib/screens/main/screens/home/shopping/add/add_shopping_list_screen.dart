import 'package:flutter/material.dart';
import 'package:fridsch_app/bl/api/household.service.dart';
import 'package:fridsch_app/bl/api/models/shopping_list.dart';
import 'package:fridsch_app/bl/api/shopping_list.service.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../../../components/emoji_row.dart';
import '../../../../../../constants.dart';
import '../components/shopping_input.dart';

class AddShoppingScreen extends StatelessWidget {
  const AddShoppingScreen({super.key, required this.addShopping});

  final Function addShopping;

  final emojiList = const {
    '🛒': Color(0xfff27557),
    '📝': Color(0xff8ed3f7),
    '🏥': Color(0xff8bc4e0),
    '⚕️': Color.fromARGB(255, 242, 89, 127),
    '💊': Color(0xffF9534B),
  };

  @override
  Widget build(BuildContext context) {
    final controller = TextEditingController();
    String emoji = emojiList.keys.first;

    emojiCallback(String newEmoji) => emoji = newEmoji;

    return Scaffold(
      backgroundColor: kBackgroundColour,
      body: SafeArea(
        child: Column(
          children: [
            const SizedBox(height: kDefPadding),
            Text(
              'Create Shopping List',
              style: GoogleFonts.quicksand(fontSize: 28),
            ),
            const SizedBox(height: kDefPadding * 3),
            Padding(
              padding: EdgeInsets.symmetric(
                  horizontal: MediaQuery.of(context).size.width * 25 / 375),
              child: EmojiRow(
                callback: emojiCallback,
                emojiList: emojiList,
              ),
            ),
            const SizedBox(height: kDefPadding),
            Padding(
              padding: EdgeInsets.symmetric(
                  horizontal: MediaQuery.of(context).size.width * 25 / 375),
              child: ShoppingInput(controller: controller),
            ),
            const SizedBox(height: kDefPadding * 2),
            TextButton(
              onPressed: () async {
                final shoppingName = controller.text;
                final shoppingEmoji = emoji;

                if (shoppingName.isEmpty) {
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
                    shape:
                        RoundedRectangleBorder(borderRadius: kDefBorderRadius),
                  ));
                  return;
                }

                final list = ShoppingList(
                    householdId: HouseholdService().currentHousehold,
                    name: shoppingName,
                    emoji: shoppingEmoji);

                ShoppingListService().create(list);
                addShopping(list);

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
    );
  }
}
