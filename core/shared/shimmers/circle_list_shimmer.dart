import 'package:almonazim/core/constant/app_color.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class CircleListShimmer extends StatelessWidget {
  const CircleListShimmer(
      {super.key,
      this.axis = Axis.vertical,
      required this.listLength,
      required this.padding,
      required this.listHeight,
      this.circleRadius});
  final Axis axis;
  final EdgeInsetsGeometry padding;
  final int listLength;
  final double? circleRadius;
  final double listHeight;
  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
        direction: ShimmerDirection.rtl,
        baseColor: AppColor.shimmerColor,
        highlightColor: Colors.grey[100]!,
        child: SizedBox(
          height: listHeight,
          child: ListView(
            scrollDirection: axis,
            children: [
              ...List.generate(
                listLength,
                (index) {
                  return Padding(
                    padding: padding,
                    child: CircleAvatar(
                      radius: circleRadius,
                      backgroundColor: AppColor.primaryColor,
                    ),
                  );
                },
              )
            ],
          ),
        ));
  }
}
