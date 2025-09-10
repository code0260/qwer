import 'package:almonazim/view/widget/subscription/user_pricing_plan_dialog.dart';
import 'package:flutter/material.dart';

/// A function to show a detailed AlertDialog explaining user subscription costs.
/// This dialog explains a tiered pricing model in Arabic.
Future<bool?> showUserPricingPlanDialog(BuildContext context) async {
  return showDialog<bool?>(
    context: context,
    builder: (BuildContext context) {
      return const UserPricingPlanDialog();
    },
  );
}
