import 'package:flutter/material.dart';
import 'package:fridsch_app/constants.dart';
import 'package:shimmer/shimmer.dart';

class LoadingListTile extends StatelessWidget {
  const LoadingListTile({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Shimmer(
      gradient: const LinearGradient(
        colors: [
          Color(0xFFEBEBF4),
          Color(0xFFF4F4F4),
          Color(0xFFEBEBF4),
        ],
        stops: [
          0.1,
          0.3,
          0.4,
        ],
        begin: Alignment(-1.0, -0.3),
        end: Alignment(1.0, 0.3),
        tileMode: TileMode.clamp,
      ),
      child: ListTile(
        leading: const CircleAvatar(radius: 20),
        title: Align(
          alignment: Alignment.centerLeft,
          child: Container(
            width: 150,
            height: 22,
            color: kBackgroundColour,
          ),
        ),
        subtitle: Align(
          alignment: Alignment.centerLeft,
          child: Container(
            width: 85,
            height: 14,
            color: kBackgroundColour,
          ),
        ),
      ),
    );
  }
}
