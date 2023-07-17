import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:fridsch_app/bl/api/household.service.dart';
import 'package:fridsch_app/bl/api/models/household.dart';
import 'package:fridsch_app/constants.dart';
import 'package:fridsch_app/screens/household/components/household_input.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../components/edit_emoji_row.dart';
import '../../../components/emoji_row.dart';

class EditHouseholdScreen extends StatefulWidget {
  const EditHouseholdScreen(
      {super.key, required this.household, required this.onDelete});

  final Household household;
  final Function onDelete;

  @override
  State<EditHouseholdScreen> createState() => _EditHouseholdScreenState();
}

class _EditHouseholdScreenState extends State<EditHouseholdScreen> {
  final emojiList = const {
    '🚀': Color(0xff769ED5),
    '🏠': Color(0xffA44A47),
    '🍯': Color.fromARGB(255, 244, 204, 83),
    '❤️': Color(0xffF9534B),
    '💜': Color(0xffB952F5),
  };

  final controller = TextEditingController();
  String emoji = '';

  @override
  void initState() {
    controller.text = widget.household.name;
    emoji = widget.household.emoji;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    emojiCallback(String emoji) {
      setState(() {
        this.emoji = emoji;
      });
    }

    print('edit household');
    return Scaffold(
      backgroundColor: kBackgroundColour,
      body: Container(
        color: emojiList[emoji]!.withOpacity(.7),
        child: Container(
          color: kBackgroundColour,
          child: Column(
            children: [
              Container(
                color: emojiList[emoji]!.withOpacity(.7),
                width: double.infinity,
                height: 180,
                padding: const EdgeInsets.only(
                    left: kDefPadding * 2, top: kDefPadding * 3.5),
                child: Text(
                  emoji,
                  style: const TextStyle(fontSize: 56),
                ),
              ),
              const SizedBox(height: kDefPadding * 2),
              EditEmojiRow(
                callback: emojiCallback,
                emojiList: emojiList,
                emoji: emoji,
              ),
              const SizedBox(height: kDefPadding),
              Padding(
                padding: EdgeInsets.symmetric(
                    horizontal: 25 / 375 * MediaQuery.of(context).size.width),
                child: HouseholdInput(controller: controller),
              ),
              const Spacer(),
              TextButton(
                onPressed: () {
                  final new_householdName = controller.text;
                  final new_householdEmoji = emoji;
                  widget.household.name = new_householdName;
                  widget.household.emoji = new_householdEmoji;

                  HouseholdService().updateHousehold(widget.household);

                  print(new_householdName + new_householdEmoji);

                  Navigator.of(context).pop();
                },
                style: TextButton.styleFrom(
                  shape: RoundedRectangleBorder(borderRadius: kDefBorderRadius),
                  fixedSize:
                      Size(MediaQuery.of(context).size.width * 325 / 375, 58),
                  backgroundColor: kOnBackgroundColour,
                  foregroundColor: kDarkContentColour,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      'Save Changes',
                      style: GoogleFonts.quicksand(
                          fontSize: 16, fontWeight: FontWeight.w600),
                    ),
                    const SizedBox(width: kDefPadding / 2),
                    const FaIcon(
                      FontAwesomeIcons.pen,
                      size: 14,
                      color: kDarkGreyContentColour,
                    ),
                  ],
                ),
              ),
              const SizedBox(height: kDefPadding / 1.5),
              TextButton(
                onPressed: () {
                  //! Delete
                  HouseholdService().delete(widget.household);
                  widget.onDelete(widget.household);
                  Navigator.of(context).pop();
                },
                style: TextButton.styleFrom(
                  shape: RoundedRectangleBorder(borderRadius: kDefBorderRadius),
                  fixedSize:
                      Size(MediaQuery.of(context).size.width * 325 / 375, 58),
                  backgroundColor: const Color(0xffff595e).withOpacity(0.9),
                  foregroundColor: kOnBackgroundColour,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      'Delete',
                      style: GoogleFonts.quicksand(
                          fontSize: 16, fontWeight: FontWeight.w600),
                    ),
                    const SizedBox(width: kDefPadding / 2),
                    const FaIcon(
                      FontAwesomeIcons.deleteLeft,
                      size: 15,
                      color: kOnBackgroundColour,
                    ),
                  ],
                ),
              ),
              const SizedBox(height: kDefPadding * 1.5),
            ],
          ),
        ),
      ),
    );
  }
}
