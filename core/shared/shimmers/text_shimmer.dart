import 'package:almonazim/core/constant/app_color.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class TextShimmer extends StatelessWidget {
  const TextShimmer({
    super.key,
    required this.data,
  });
  final String data;

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
        direction: ShimmerDirection.rtl,
        baseColor: AppColor.shimmerColor,
        highlightColor: Colors.grey[100]!,
        child: Text(data));
  }
}
