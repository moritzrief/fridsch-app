import 'package:flutter/material.dart';
import 'package:fridsch_app/constants.dart';
import 'loading_list_tile.dart';

class LoadingList extends StatelessWidget {
  const LoadingList({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      shrinkWrap: true,
      itemCount: 12,
      itemBuilder: (context, index) => const LoadingListTile(),
    );
  }
}
