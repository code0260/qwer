import 'package:almonazim/core/helper/overlay/floating_overlay_icons.dart';
import 'package:almonazim/data/data%20source/locale/store_show_overlay_icons.dart';

void waitThenShowOverlayIcons(context) {
  if (StoreShowOverlayIcons.getShowOverlayIcons() == false) {
    return;
  }
  Future.delayed(
    const Duration(seconds: 1),
    () {
      FloatingOverlayIcons.showFloatingOverlayIcons(context: context);
    },
  );
}
