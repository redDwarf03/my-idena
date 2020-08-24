import 'package:fleva_icons/fleva_icons.dart';
import 'package:flutter/material.dart';

class TabIconData {
  TabIconData({
    this.index = 0,
    this.isSelected = false,
    this.animationController,
    this.icon,
    this.selectedIcon
  });

  bool isSelected;
  int index;
  Icon icon;
  Icon selectedIcon;

  AnimationController animationController;

  static List<TabIconData> tabIconsList = <TabIconData>[
    TabIconData(
      index: 0,
      isSelected: true,
      animationController: null,
      icon: Icon(FlevaIcons.globe_2_outline, size: 40, color: Colors.black,),
      selectedIcon: Icon(FlevaIcons.globe_2_outline, size: 40, color: Colors.grey[500],)
    ),
    TabIconData(
      index: 1,
      isSelected: false,
      animationController: null,
      icon: Icon(FlevaIcons.clock_outline, size: 40, color: Colors.black,),
      selectedIcon: Icon(FlevaIcons.clock_outline, size: 40, color: Colors.grey[500],)
    ),
    TabIconData(
      index: 2,
      isSelected: false,
      animationController: null,
      icon: Icon(FlevaIcons.settings_2_outline, size: 40, color: Colors.black,),
      selectedIcon: Icon(FlevaIcons.settings_2_outline, size: 40, color: Colors.grey[500],)
    ),
    TabIconData(
      index: 3,
      isSelected: false,
      animationController: null,
      icon: Icon(Icons.info_outline, size: 40, color: Colors.black,),
      selectedIcon: Icon(Icons.info_outline, size: 40, color: Colors.grey[500],)
    ),
  ];
}
