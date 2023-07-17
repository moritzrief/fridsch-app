import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:fridsch_app/constants.dart';
import 'package:fridsch_app/screens/main/screens/home/home_screen.dart';

import '../../bl/api/models/household.dart';

class MainScreen extends StatelessWidget {
  const MainScreen({super.key, required this.household});

  final Household household;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kBackgroundColour,
      body: SafeArea(
        child: HomeScreen(
          household: household,
        ),
      ),
    );
  }
}
