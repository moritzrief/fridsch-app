import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:fridsch_app/bl/api/household.service.dart';
import 'package:fridsch_app/bl/api/models/household.dart';
import 'package:fridsch_app/components/emoji_text_button.dart';
import 'package:fridsch_app/constants.dart';
import 'package:fridsch_app/screens/household/add/add_household_screen.dart';
import 'package:fridsch_app/screens/household/components/household_input.dart';
import 'package:fridsch_app/screens/main/screens/storage/components/universial_input.dart';
import 'package:google_fonts/google_fonts.dart';
import 'components/header.dart';
import 'components/household_button_list.dart';

class HouseholdScreen extends StatefulWidget {
  const HouseholdScreen({super.key});

  @override
  State<HouseholdScreen> createState() => _HouseholdScreenState();
}

class _HouseholdScreenState extends State<HouseholdScreen> {
  late Future<List<Household>> households;

  @override
  void initState() {
    households = HouseholdService().getHouseholds();
    super.initState();
  }

  addHousehold(Household household) {
    setState(() {
      households.then((value) => value.add(household));
    });
  }

  updateHousehold() {
    setState(() {});
  }

  removeHousehold(Household household) {
    setState(() {
      households.then((value) => value.remove(household));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: kBackgroundColour,
      body: SafeArea(
        child: Column(
          children: [
            const SizedBox(height: kDefPadding / 2),
            const Header(),
            const Spacer(),
            FutureBuilder(
                future: households,
                builder: ((context, snapshot) {
                  return snapshot.hasData
                      ? HouseholdList(
                          households: snapshot.data!,
                          onUpdate: updateHousehold,
                          onDelete: removeHousehold,
                        )
                      : Container();
                })),
            const SizedBox(height: kDefPadding * 2),
            EmojiTextButton(
              prefixEmoji: '🌐',
              buttonText: 'Join a Household',
              onTap: () {
                final controller = TextEditingController();
                showModalBottomSheet(
                  backgroundColor: kBackgroundColour,
                  context: context,
                  builder: (context) => Column(
                    children: [
                      const SizedBox(height: kDefPadding),
                      Text(
                        'Enter Household Token',
                        style: GoogleFonts.quicksand(
                          fontSize: 22,
                        ),
                      ),
                      const SizedBox(height: kDefPadding),
                      Padding(
                        padding: EdgeInsets.symmetric(
                            horizontal:
                                MediaQuery.of(context).size.width * 25 / 375),
                        child: UniversialInput(
                          controller: controller,
                          hint: 'Token',
                          icon: FontAwesomeIcons.house,
                        ),
                      ),
                      const SizedBox(height: kDefPadding),
                      TextButton(
                        onPressed: () async {
                          if (await HouseholdService().join(controller.text)) {
                            final snackBar = SnackBar(
                              content: Text(
                                'Successfully joined Household!',
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
                            ScaffoldMessenger.of(context)
                                .showSnackBar(snackBar);
                            households = HouseholdService().getHouseholds();
                            setState(() {});
                          } else {
                            final snackBar = SnackBar(
                              content: Text(
                                'There has been an error with joining the Household!',
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
                            ScaffoldMessenger.of(context)
                                .showSnackBar(snackBar);
                          }
                          Navigator.of(context).pop();
                        },
                        style: TextButton.styleFrom(
                          shape: RoundedRectangleBorder(
                              borderRadius: kDefBorderRadius),
                          fixedSize: Size(
                              MediaQuery.of(context).size.width * 325 / 375,
                              58),
                          backgroundColor: kOnBackgroundColour,
                          foregroundColor: kDarkContentColour,
                        ),
                        child: Text('Join Household',
                            style: GoogleFonts.nunito(
                              fontWeight: FontWeight.w600,
                              fontSize: 18,
                            )),
                      ),
                    ],
                  ),
                );
              },
              settings: false,
              settingsOnTap: () {},
            ),
            const SizedBox(height: kDefPadding),
            EmojiTextButton(
              prefixEmoji: '➕',
              buttonText: 'Create a Household',
              onTap: () {
                Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) =>
                      AddHouseholdScreen(addHousehold: addHousehold),
                ));
              },
              settings: false,
              settingsOnTap: () {},
            ),
            const Spacer(flex: 2),
          ],
        ),
      ),
    );
  }
}
