import 'package:flutter/material.dart';
import 'package:fridsch_app/screens/main/screens/storage/components/storage_input.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../../bl/api/household.service.dart';
import '../../../../../bl/api/models/storage.dart';
import '../../../../../bl/api/storage.service.dart';
import '../../../../../components/emoji_row.dart';
import '../../../../../constants.dart';

class AddStorageScreen extends StatelessWidget {
  const AddStorageScreen({super.key, required this.addStorage});

  final Function addStorage;

  final emojiList = const {
    '🔥': Color(0xfff27557),
    '❄️': Color(0xff8ed3f7),
    '🧊': Color(0xff8bc4e0),
    '💯': Color.fromARGB(255, 242, 89, 127),
    '❤️': Color(0xffF9534B),
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
              'Create Storage',
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
              child: StorageInput(controller: controller),
            ),
            const SizedBox(height: kDefPadding * 2),
            TextButton(
              onPressed: () async {
                final storageName = controller.text;
                final storageEmoji = emoji;

                final newStorage = Storage(
                    householdId: HouseholdService().currentHousehold,
                    name: storageName,
                    emoji: storageEmoji);
                print("$storageEmoji $storageName");

                if (storageName.isEmpty) {
                  //empty name
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                    content: Text(
                      'No fields must be empty',
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
                await StorageService().create(newStorage)
                    ? ScaffoldMessenger.of(context)
                        .showSnackBar(const SnackBar(content: Text('Created')))
                    : ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('Not Created')));

                addStorage(newStorage);
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
