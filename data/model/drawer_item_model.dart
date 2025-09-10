import 'package:flutter/material.dart';

class DrawerItemModel {
  final String title;
  final String? feature;
  final IconData? icon;
  final String? image;

  const DrawerItemModel(
      {required this.title, this.feature, this.icon, this.image});
}
