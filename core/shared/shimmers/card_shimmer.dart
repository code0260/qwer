import 'package:almonazim/core/constant/app_color.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class CardShimmer extends StatelessWidget {
  const CardShimmer({super.key, required this.height, this.width});

  final double height;
  final double? width;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(5.0),
      child: Shimmer.fromColors(
          direction: ShimmerDirection.rtl,
          baseColor: AppColor.shimmerColor,
          highlightColor: Colors.grey[100]!,
          child: Card(
            elevation: 3,
            child: SizedBox(
              height: height,
              width: width,
            ),
          )),
    );
  }
}
