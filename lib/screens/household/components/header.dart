import 'package:flutter/material.dart';

import '../../../constants.dart';

class Header extends StatelessWidget {
  const Header({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      child: Text(
        'Choose Household',
        textAlign: TextAlign.center,
        style: kScreenHeaderTextStyle.copyWith(color: kGreyContentColour),
      ),
    );
  }
}
