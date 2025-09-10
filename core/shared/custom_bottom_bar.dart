import 'package:almonazim/core/constant/app_color.dart';
import 'package:almonazim/data.dart';
import 'package:almonazim/data/data%20source/locale/store_work_offline.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class CustomBottomBar extends StatelessWidget {
  const CustomBottomBar({super.key});

  @override
  Widget build(BuildContext context) {
    final TabController tabController = DefaultTabController.of(context);
    return AnimatedBuilder(
      animation: tabController,
      builder: (context, _) {
        return ClipRRect(
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(25),
            topRight: Radius.circular(25),
          ),
          child: BottomNavigationBar(
            currentIndex: tabController.index,
            onTap: (index) async {
              if (index == 1) {
                await StoreWorkOffline.setWorkOffline(workingOffline);
              } else {
                await StoreWorkOffline.setWorkOffline(false);
              }
              tabController.animateTo(index);
            },
            backgroundColor: AppColor.whiteDarkSame,
            selectedItemColor: AppColor.primaryColor,
            unselectedItemColor: AppColor.whiteMainReverse,
            elevation: 5,
            type: BottomNavigationBarType.fixed,
            items: const [
              BottomNavigationBarItem(
                icon: Padding(
                  padding: EdgeInsets.only(top: 8),
                  child: Icon(Icons.home),
                ),
                label: 'الرئيسية',
              ),
              BottomNavigationBarItem(
                icon: Padding(
                  padding: EdgeInsets.only(top: 8),
                  child: Icon(Icons.payment),
                ),
                label: 'الفواتير',
              ),
              BottomNavigationBarItem(
                icon: Padding(
                  padding: EdgeInsets.only(top: 8),
                  child: Icon(Icons.analytics),
                ),
                label: 'التقارير',
              ),
              BottomNavigationBarItem(
                icon: Padding(
                  padding: EdgeInsets.only(top: 8),
                  child: Icon(FontAwesomeIcons.handHoldingDollar),
                ),
                label: 'الديون',
              ),
              BottomNavigationBarItem(
                icon: Padding(
                  padding: EdgeInsets.only(top: 8),
                  child: Icon(Icons.person),
                ),
                label: 'الحساب',
              ),
            ],
          ),
        );
      },
    );
  }
}
