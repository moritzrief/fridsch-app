import 'package:flutter/material.dart';
import 'package:fridsch_app/screens/household/edit/edit_household_screen.dart';
import 'package:fridsch_app/screens/main/main_screen.dart';

import '../../../bl/api/household.service.dart';
import '../../../bl/api/models/household.dart';
import '../../../components/emoji_text_button.dart';

class HouseholdButton extends StatelessWidget {
  const HouseholdButton({
    super.key,
    required this.household,
    required this.onUpdate,
    required this.onDelete,
  });

  final Household household;
  final Function onUpdate;
  final Function onDelete;

  @override
  Widget build(BuildContext context) {
    return EmojiTextButton(
      prefixEmoji: household.emoji,
      buttonText: household.name,
      onTap: () {
        HouseholdService().currentHousehold = household.id;
        Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(
            builder: (context) => MainScreen(household: household),
          ),
          (route) => false,
        );
      },
      settings: household.admin,
      settingsOnTap: () {
        Navigator.of(context)
            .push(MaterialPageRoute(
              builder: (context) =>
                  EditHouseholdScreen(household: household, onDelete: onDelete),
            ))
            .then((value) => onUpdate());
      },
    );
  }
}
