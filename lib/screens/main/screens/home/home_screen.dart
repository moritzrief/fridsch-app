import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:fridsch_app/bl/api/household.service.dart';
import 'package:fridsch_app/bl/api/user.service.dart';
import 'package:fridsch_app/constants.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../../bl/api/models/household.dart';
import 'components/recipe_element.dart';
import 'components/shopping_list/shopping_list_element.dart';
import 'components/storage/storage_element.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key, required this.household});

  final Household household;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          Container(
            width: MediaQuery.of(context).size.width,
            padding: const EdgeInsets.symmetric(horizontal: kDefPadding),
            child: Row(
              //mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                IconButton(
                  onPressed: () {
                    //todo account page
                  },
                  icon: const FaIcon(
                    FontAwesomeIcons.solidCircleUser,
                    size: 20,
                    color: kDarkGreyContentColour,
                  ),
                ),
                const Spacer(),
                household.admin
                    ? IconButton(
                        onPressed: () async {
                          //todo usr management site
                          final token = await HouseholdService().createToken();
                          await Clipboard.setData(ClipboardData(text: token));
                          final snackBar = SnackBar(
                            content: Text(
                              'Copied Household Token to Clipboard!',
                              style: GoogleFonts.nunito(
                                color: kDarkGreyContentColour,
                                fontWeight: FontWeight.w600,
                                fontSize: 16,
                              ),
                            ),
                            behavior: SnackBarBehavior.floating,
                            backgroundColor: kOnBackgroundColour,
                            shape: RoundedRectangleBorder(
                                borderRadius: kDefBorderRadius),
                          );
                          ScaffoldMessenger.of(context).showSnackBar(snackBar);
                        },
                        icon: const FaIcon(
                          FontAwesomeIcons.users,
                          size: 20,
                          color: kDarkGreyContentColour,
                        ),
                      )
                    : Container(),
                IconButton(
                    onPressed: () {
                      Navigator.of(context).pushNamed('/household');
                    },
                    icon: const FaIcon(
                      FontAwesomeIcons.houseUser,
                      size: 20,
                      color: kDarkGreyContentColour,
                    )),
              ],
            ),
          ),
          Container(
              width: double.infinity,
              padding: EdgeInsets.only(
                  left: 25 / 375 * MediaQuery.of(context).size.width,
                  top: kDefPadding),
              child: makeUsernameHeader()),
          const SizedBox(height: kDefPadding * 1.5),
          const StorageElement(),
          const SizedBox(height: kDefPadding * 2),
          const ShoppingListElement(),
          const SizedBox(height: kDefPadding * 2),
          const RecipeElement(),
        ],
      ),
    );
  }

  FutureBuilder<String> makeUsernameHeader() {
    return FutureBuilder(
      builder: (context, snapshot) => snapshot.hasData
          ? Text(
              'Hi ${snapshot.data}!',
              style: GoogleFonts.domine(
                fontSize: 32,
                fontWeight: FontWeight.w500,
              ),
            )
          : Text(
              'Hi Friend!',
              style: GoogleFonts.domine(
                fontSize: 32,
                fontWeight: FontWeight.w500,
              ),
            ),
      future: UserService().getUsername(),
    );
  }
}
