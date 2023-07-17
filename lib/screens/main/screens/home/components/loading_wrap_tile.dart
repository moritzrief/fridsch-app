import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

import '../../../../../constants.dart';

class LoadingCategoryWrapTile extends StatelessWidget {
  const LoadingCategoryWrapTile({
    super.key,
  });

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
      child: UnconstrainedBox(
        child: Container(
          width: 50,
          height: 25,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(8),
          ),
        ),
      ),
    );
  }
}
