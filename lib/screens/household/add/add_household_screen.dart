import 'package:flutter/material.dart';
import 'package:fridsch_app/bl/api/household.service.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../bl/api/models/household.dart';
import '../../../components/emoji_row.dart';
import '../../../constants.dart';
import '../components/household_input.dart';

class AddHouseholdScreen extends StatelessWidget {
  const AddHouseholdScreen({super.key, required this.addHousehold});

  final Function addHousehold;

  final emojiList = const {
    '🚀': Color(0xff769ED5),
    '🏠': Color(0xffA44A47),
    '🍯': Color.fromARGB(255, 244, 204, 83),
    '❤️': Color(0xffF9534B),
    '💜': Color(0xffB952F5),
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
              'Create Household',
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
              child: HouseholdInput(controller: controller),
            ),
            const SizedBox(height: kDefPadding * 2),
            TextButton(
              onPressed: () async {
                final householdName = controller.text;
                final householdEmoji = emoji;

                if (householdName.isEmpty) {
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                    content: Text(
                      'No fields must be empty!',
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

                Household res = await HouseholdService()
                    .addHousehold(householdName, householdEmoji);
                res.admin = true;
                addHousehold(res);
                Navigator.of(context).pop();
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
