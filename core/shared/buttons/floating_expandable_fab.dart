import 'package:almonazim/core/constant/app_color.dart';
import 'package:almonazim/core/shared/calculator_icon.dart';
import 'package:almonazim/view/widget/feedback/feedback_icon.dart';
import 'package:flutter/material.dart';
import 'package:flutter_expandable_fab/flutter_expandable_fab.dart';
import 'package:get/get.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

class FloatingExpandableFab extends StatefulWidget {
  const FloatingExpandableFab({super.key});

  @override
  State<FloatingExpandableFab> createState() => _FloatingExpandableFabState();
}

class _FloatingExpandableFabState extends State<FloatingExpandableFab> {
  Offset _position =
      Offset(Get.width - 80, Get.height / 1.5); // Initial position (x, y)
  final GlobalKey<ExpandableFabState> fabKey = GlobalKey<ExpandableFabState>();
  @override
  Widget build(BuildContext context) {
    return Positioned(
      left: _position.dx,
      top: _position.dy,
      child: GestureDetector(
        onPanUpdate: (details) {
          setState(() {
            final screenSize = MediaQuery.of(context).size;
            final newOffset = _position + details.delta;

            // حدود السحب
            const minX = 0.0;
            final maxX = screenSize.width - 80; // حجم الـ SizedBox
            const minY = 0.0;
            final maxY = screenSize.height - 200; // حجم الـ SizedBox

            _position = Offset(
              newOffset.dx.clamp(minX, maxX),
              newOffset.dy.clamp(minY, maxY),
            );
          });
        },
        child: SizedBox(
          width: 80,
          height: 220,
          child: ExpandableFab(
            key: fabKey,
            openButtonBuilder: RotateFloatingActionButtonBuilder(
              elevation: 1,
              child: Icon(MdiIcons.dotsVertical),
              fabSize: ExpandableFabSize.small,
              foregroundColor: AppColor.white,
              backgroundColor: AppColor.primaryColor,
              shape: const CircleBorder(),
            ),
            closeButtonBuilder: DefaultFloatingActionButtonBuilder(
              child: const Icon(Icons.close),
              fabSize: ExpandableFabSize.small,
              foregroundColor: AppColor.white,
              backgroundColor: AppColor.primaryColor,
              shape: const CircleBorder(),
            ),
            type: ExpandableFabType.up,
            distance: 60,
            children: [
              FeedbackIcon(
                onFeedbackPressed: () {
                  fabKey.currentState?.toggle();
                },
              ),
              CalculatorIcon(
                onCalculatorDialogOpened: () {
                  fabKey.currentState?.toggle();
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
