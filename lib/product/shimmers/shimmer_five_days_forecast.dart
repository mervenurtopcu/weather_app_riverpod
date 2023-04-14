import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';
import '../constants/color_constants.dart';

class ShimmerFiveDaysForecast extends StatelessWidget {
  const ShimmerFiveDaysForecast({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: ColorsConstants.blackColor.withOpacity(0.5),
      highlightColor:ColorsConstants.blackColor.withOpacity(1),
      child: ListView.separated(
        itemCount: 25,
        itemBuilder: (context, index) {
          return Card(
              color: Colors.black.withOpacity(0.5),
              margin: const EdgeInsets.all(8),
              child: Container(
                height: 90,
                color: Colors.black.withOpacity(0.5),
              )
          );
        },
        separatorBuilder: (context, index) {
          return const SizedBox(
            width: 10,
          );
        },
      ),);
  }
}
