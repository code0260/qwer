import 'package:almonazim/core/constant/app_color.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class TextFieldShimmer extends StatelessWidget {
  const TextFieldShimmer({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
        direction: ShimmerDirection.rtl,
        baseColor: AppColor.shimmerColor,
        highlightColor: Colors.grey[100]!,
        child: const TextField(readOnly: true));
  }
}
