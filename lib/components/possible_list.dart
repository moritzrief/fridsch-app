import 'package:flutter/material.dart';
import 'package:fridsch_app/constants.dart';
import 'package:google_fonts/google_fonts.dart';

class PossibleList extends StatelessWidget {
  const PossibleList({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(20),
      decoration: BoxDecoration(
          color: kOnBackgroundColour, borderRadius: kDefBorderRadius),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextButton(
              onPressed: () {},
              child:
                  Row(crossAxisAlignment: CrossAxisAlignment.center, children: [
                Text(
                  '🏠',
                  style: TextStyle(fontSize: 28),
                ),
                const SizedBox(width: 20),
                Text(
                  'Home',
                  style: GoogleFonts.quicksand(
                    color: kDarkContentColour,
                    fontSize: 20,
                    fontWeight: FontWeight.w600,
                  ),
                )
              ]),
            ),
          ),
          Divider(),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextButton(
              onPressed: () {},
              child:
                  Row(crossAxisAlignment: CrossAxisAlignment.center, children: [
                Text(
                  '❤️',
                  style: TextStyle(fontSize: 28),
                ),
                const SizedBox(width: 20),
                Text(
                  'Girlfriends\'s Place',
                  style: GoogleFonts.quicksand(
                    color: kDarkContentColour,
                    fontSize: 20,
                    fontWeight: FontWeight.w600,
                  ),
                )
              ]),
            ),
          ),
          Divider(),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextButton(
              onPressed: () {},
              child:
                  Row(crossAxisAlignment: CrossAxisAlignment.center, children: [
                Text(
                  '🤝',
                  style: TextStyle(fontSize: 28),
                ),
                const SizedBox(width: 20),
                Text(
                  'Lost Boy\'s Home',
                  style: GoogleFonts.quicksand(
                    color: kDarkContentColour,
                    fontSize: 20,
                    fontWeight: FontWeight.w600,
                  ),
                )
              ]),
            ),
          ),
        ],
      ),
    );
  }
}
