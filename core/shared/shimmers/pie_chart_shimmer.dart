import 'package:almonazim/core/constant/app_design_endpoint.dart';
import 'package:almonazim/core/shared/shimmers/card_shimmer.dart';
import 'package:almonazim/core/shared/shimmers/circle_shimmer.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

class PieChartShimmer extends StatelessWidget {
  const PieChartShimmer({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    bool isMobile = AppDesignEndpoint.isMobile(context);
    return isMobile
        ? Column(
            children: [
              Align(
                  alignment: Alignment.topRight,
                  child: SizedBox(
                      width: Get.width / 1.5,
                      child: const CardShimmer(height: 140))),
              // const Spacer(),
              const SizedBox(height: 20),
              const CircleShimmer(
                height: 150,
                circleRadius: 70,
              )
            ],
          )
        : const Row(
            children: [
              Align(
                  alignment: Alignment.topRight,
                  child: SizedBox(width: 500, child: CardShimmer(height: 140))),
              SizedBox(height: 20),
              Expanded(
                flex: 2,
                child: CircleShimmer(
                  height: 200,
                  circleRadius: 100,
                ),
              )
            ],
          );
  }
}
