import 'package:fleva_icons/fleva_icons.dart';
import 'package:flutter/material.dart';

class TabIconData {
  TabIconData({
    this.index = 0,
    this.isSelected = false,
    this.isActive = true,
    this.animationController,
    this.icon,
    this.selectedIcon,
    this.inactiveIcon
  });

  bool isSelected;
  bool isActive;
  int index;
  Icon icon;
  Icon selectedIcon;
  Icon inactiveIcon;

  AnimationController animationController;

  static List<TabIconData> tabIconsList = <TabIconData>[
    TabIconData(
      index: 0,
      isSelected: true,
      isActive: true,
      animationController: null,
      icon: Icon(Icons.add_circle_outline, size: 40, color: Colors.black,),
      selectedIcon: Icon(Icons.add_circle_outline, size: 40, color: Colors.black,),
      inactiveIcon: Icon(Icons.add_circle_outline, size: 40, color: Colors.white,)
    ),
    TabIconData(
      index: 1,
      isSelected: true,
      isActive: true,
      animationController: null,
      icon: Icon(FlevaIcons.globe_2_outline, size: 40, color: Colors.black,),
      selectedIcon: Icon(FlevaIcons.globe_2_outline, size: 40, color: Colors.grey[500],),
      inactiveIcon: Icon(FlevaIcons.globe_2_outline, size: 40, color: Colors.white,)
    ),
    TabIconData(
      index: 2,
      isSelected: false,
      isActive: true,
      animationController: null,
      icon: Icon(FlevaIcons.settings_2_outline, size: 40, color: Colors.black,),
      selectedIcon: Icon(FlevaIcons.settings_2_outline, size: 40, color: Colors.grey[500],),
      inactiveIcon: Icon(FlevaIcons.settings_2_outline, size: 40, color: Colors.white,)
    ),
    TabIconData(
      index: 3,
      isSelected: false,
      isActive: true,
      animationController: null,
      icon: Icon(Icons.info_outline, size: 40, color: Colors.black,),
      selectedIcon: Icon(Icons.info_outline, size: 40, color: Colors.grey[500],),
      inactiveIcon: Icon(Icons.info_outline, size: 40, color: Colors.white,)
    ),
  ];
}
