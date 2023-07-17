import 'package:flutter/material.dart';
import 'package:fridsch_app/constants.dart';
import 'package:shimmer/shimmer.dart';

class LoadingRowTile extends StatelessWidget {
  const LoadingRowTile({
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
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: kDefPadding / 2),
        //height: 195,
        width: 175,
        child: Container(
          decoration: BoxDecoration(
            borderRadius: kDefBorderRadius,
            color: kOnBackgroundColour,
            // boxShadow: const [
            //   BoxShadow(
            //       color: kGreyContentColour,
            //       offset: Offset(0, 2),
            //       blurRadius: 3),
            // ],
          ),
        ),
      ),
    );
  }
}