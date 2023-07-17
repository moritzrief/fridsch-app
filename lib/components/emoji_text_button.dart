import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:fridsch_app/constants.dart';
import 'package:fridsch_app/screens/household/edit/edit_household_screen.dart';
import 'package:google_fonts/google_fonts.dart';

class EmojiTextButton extends StatelessWidget {
  const EmojiTextButton({
    Key? key,
    required this.prefixEmoji,
    required this.buttonText,
    required this.onTap,
    required this.settings,
    required this.settingsOnTap,
  }) : super(key: key);

  final String prefixEmoji;
  final String buttonText;
  final Function onTap;
  final bool settings;
  final Function settingsOnTap;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(
          horizontal: 25 / 375 * MediaQuery.of(context).size.width),
      child: ElevatedButton(
        onPressed: () => onTap(),
        style: ElevatedButton.styleFrom(
          elevation: 3,
          fixedSize: Size(325 / 375 * MediaQuery.of(context).size.width, 65),
          maximumSize: Size(325 / 375 * MediaQuery.of(context).size.width, 65),
          shape: RoundedRectangleBorder(borderRadius: kDefBorderRadius),
          backgroundColor: kOnBackgroundColour,
        ),
        child: Row(crossAxisAlignment: CrossAxisAlignment.center, children: [
          Text(
            prefixEmoji,
            style: const TextStyle(fontSize: 28),
          ),
          const SizedBox(width: 20),
          Text(
            buttonText,
            style: GoogleFonts.quicksand(
              color: kDarkContentColour,
              fontSize: 20,
              fontWeight: FontWeight.w600,
            ),
          ),
          const Spacer(),
          settings
              ? GestureDetector(
                  onTap: () => settingsOnTap(),
                  child: Container(
                    color: kOnBackgroundColour,
                    width: 30,
                    height: 65,
                    child: const Center(
                      child: FaIcon(
                        FontAwesomeIcons.ellipsisVertical,
                        color: kDarkGreyContentColour,
                        size: 19,
                      ),
                    ),
                  ),
                )
              : const SizedBox(),
        ]),
      ),
    );
  }
}
