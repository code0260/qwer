import 'package:almonazim/view/widget/users/logout_user_dilaog.dart';
import 'package:flutter/material.dart';

Future<void> showLogoutDialog(BuildContext context) async {
  return showDialog<void>(
    context: context,
    builder: (BuildContext context) {
      return const LogoutUserDialog();
    },
  );
}
