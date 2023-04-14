import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';
import '../../product/constants/index.dart';


class ShimmerWeatherInformation extends StatelessWidget {
  const ShimmerWeatherInformation({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: ColorsConstants.blackColor.withOpacity(0.5),
      highlightColor:ColorsConstants.blackColor.withOpacity(1),
      child: Padding(
        padding: PaddingConstants.paddingWeatherInformation,
        child: Center(
          child: Column(
            children: [
              Container(
                width: 100,
                height: 10,
                color: ColorsConstants.blackColor.withOpacity(0.5),
              ),
              const SizedBox(
                height: 10,
              ),
              Container(
                width: 50,
                height: 10,
                color: ColorsConstants.blackColor.withOpacity(0.5),
              ),
              const SizedBox(
                height: 10,
              ),
              Container(
                width: 100,
                height: 10,
                color: ColorsConstants.blackColor.withOpacity(0.5),

              ),
            ],
          ),
        ),
      ),
    );
  }
}
