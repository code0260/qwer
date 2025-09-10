import 'package:almonazim/core/constant/app_main_features.dart';
import 'package:almonazim/cubits/safe_cubit.dart';
import 'package:equatable/equatable.dart';

part 'drawer_navigation_cubit_state.dart';

class DrawerNavigationCubit extends SafeCubit<String> {
  DrawerNavigationCubit() : super(AppMainFeatures.home);
  int activeIndex = 0;
  String feature = AppMainFeatures.home;

  void changeFeature(String feature) {
    emit(feature);
  }
}
