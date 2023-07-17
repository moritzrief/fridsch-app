import 'package:flutter/material.dart';
import 'package:fridsch_app/constants.dart';
import 'package:google_fonts/google_fonts.dart';

class ThreeTextHeader extends StatelessWidget {
  const ThreeTextHeader({
    Key? key,
    required this.pageName,
    required this.title,
    required this.subtitle,
    required this.pageNameStyle,
    required this.titleStyle,
    required this.subtitleStyle,
  }) : super(key: key);

  final String pageName, title, subtitle;
  final TextStyle pageNameStyle, titleStyle, subtitleStyle;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * .25,
      child: Column(
        children: [
          const SizedBox(height: kDefPadding / 2),
          Text(
            pageName,
            textAlign: TextAlign.center,
            style: pageNameStyle,
          ),
          const Spacer(),
          Container(
            width: MediaQuery.of(context).size.width,
            padding: const EdgeInsets.only(left: kDefPadding * 2),
            child: Text(
              title,
              textAlign: TextAlign.left,
              style: titleStyle,
            ),
          ),
          Container(
            width: MediaQuery.of(context).size.width,
            padding: const EdgeInsets.only(left: kDefPadding * 2),
            child: Text(
              subtitle,
              textAlign: TextAlign.left,
              style: subtitleStyle,
            ),
          ),
          const Spacer(),
        ],
      ),
    );
  }
}
