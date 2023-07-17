import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../../constants.dart';

class SearchBar extends StatelessWidget {
  const SearchBar({
    super.key,
    required this.callback, required this.hint,
  });

  final Function callback;
  final String hint;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width * .85,
      child: TextField(
        onChanged: (value) => callback(value),
        autocorrect: false,
        focusNode: null,
        decoration: InputDecoration(
          prefixIcon: const Padding(
            padding: EdgeInsets.all(15),
            child: FaIcon(
              FontAwesomeIcons.magnifyingGlass,
              color: kGreyContentColour,
              size: 17,
            ),
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15),
            borderSide: BorderSide.none,
          ),
          filled: true,
          fillColor: kOnBackgroundColour,
          hintText: hint,
          contentPadding: const EdgeInsets.all(0),
          hintStyle: GoogleFonts.openSans(
            fontSize: 15,
            color: kGreyContentColour,
          ),
        ),
      ),
    );
  }
}
