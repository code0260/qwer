import 'package:almonazim/view/widget/invoice/view%20invoice/card_invoice_shimmer.dart';
import 'package:flutter/material.dart';

class GetInvoicesShimmer extends StatelessWidget {
  const GetInvoicesShimmer({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
          maxCrossAxisExtent: 630, mainAxisExtent: 400, childAspectRatio: 6),
      itemCount: 6,
      itemBuilder: (context, index) {
        return const CardInvoiceShimmer();
      },
    );
  }
}
