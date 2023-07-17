import 'package:flutter/material.dart';

import '../../../bl/api/models/household.dart';
import '../../../constants.dart';
import 'household_button.dart';

class HouseholdList extends StatelessWidget {
  const HouseholdList({
    super.key,
    required this.households,
    required this.onUpdate,
    required this.onDelete,
  });

  final List<Household> households;
  final Function onUpdate;
  final Function onDelete;

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemCount: households.length,
        itemBuilder: ((context, index) {
          return HouseholdButton(
              household: households[index],
              onUpdate: onUpdate,
              onDelete: onDelete);
        }),
        separatorBuilder: (context, index) =>
            const SizedBox(height: kDefPadding));
  }
}
