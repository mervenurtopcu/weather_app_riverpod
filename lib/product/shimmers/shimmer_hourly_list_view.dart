import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

import '../constants/color_constants.dart';

class ShimmerHourlyListView extends StatelessWidget {
  const ShimmerHourlyListView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: ColorsConstants.blackColor.withOpacity(0.5),
      highlightColor:ColorsConstants.blackColor.withOpacity(1),
      child: ListView.separated(
          scrollDirection: Axis.horizontal,
          itemBuilder: (context, index) {
            return Container(
              width: 60,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(40),
                color: Colors.black.withOpacity(0.5),
              ),
            );
          },
          separatorBuilder: (context, index) {
            return const SizedBox(
              width: 10,
            );
          },
          itemCount: 12),
    );
  }
}
