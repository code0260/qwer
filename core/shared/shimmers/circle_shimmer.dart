import 'package:almonazim/core/constant/app_color.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class CircleShimmer extends StatelessWidget {
  const CircleShimmer({
    super.key,
    required this.height,
    this.circleRadius,
  });
  final double? circleRadius;
  final double height;

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
        direction: ShimmerDirection.rtl,
        baseColor: AppColor.shimmerColor,
        highlightColor: Colors.grey[100]!,
        child: SizedBox(
            height: height,
            child: Padding(
              padding: const EdgeInsets.all(3),
              child: CircleAvatar(
                radius: circleRadius,
                backgroundColor: AppColor.primaryColor,
              ),
            )));
  }
}
