import 'package:almonazim/core/shared/shimmers/card_shimmer.dart';
import 'package:almonazim/core/constant/app_design_endpoint.dart';
import 'package:flutter/widgets.dart';

class LineChartShimmer extends StatelessWidget {
  const LineChartShimmer({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: SizedBox(
          width: AppDesignEndpoint.isMobile(context)
              ? MediaQuery.of(context).size.width
              : MediaQuery.of(context).size.width / 3,
          child: const CardShimmer(height: 320)),
    );
  }
}
