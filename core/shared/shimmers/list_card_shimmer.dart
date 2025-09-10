import 'package:almonazim/core/shared/shimmers/card_shimmer.dart';
import 'package:flutter/material.dart';

class ListCardShimmer extends StatelessWidget {
  const ListCardShimmer({
    super.key,
    required this.length,
    required this.uintHeight,
    this.listHeight,
    this.isGrid = false,
  });
  final int length;
  final double uintHeight;
  final double? listHeight;
  final bool isGrid;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: listHeight,
      child: isGrid
          ? GridView(
              gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                  maxCrossAxisExtent: uintHeight * 3, mainAxisExtent: 200),
              children: List.generate(
                  length, (index) => CardShimmer(height: uintHeight)),
            )
          : ListView(
              children: List.generate(
                  length, (index) => CardShimmer(height: uintHeight)),
            ),
    );
  }
}
