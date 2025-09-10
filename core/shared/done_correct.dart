import 'package:almonazim/core/constant/app_color.dart';
import 'package:flutter/material.dart';

class DoneCorrect extends StatelessWidget {
  const DoneCorrect({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      backgroundColor: AppColor.green,
      child: CircleAvatar(
        radius: 17,
        backgroundColor: AppColor.whiteBlackSame,
        child: Icon(
          Icons.check,
          color: AppColor.green,
        ),
      ),
    );
  }
}
