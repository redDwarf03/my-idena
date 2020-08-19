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
      icon: Icon(Icons.home, size: 40, color: Colors.black,),
      selectedIcon: Icon(Icons.home, size: 40, color: Colors.green[300],)
    ),
    TabIconData(
      index: 1,
      isSelected: false,
      animationController: null,
      icon: Icon(Icons.burst_mode, size: 40, color: Colors.black,),
      selectedIcon: Icon(Icons.burst_mode, size: 40, color: Colors.green[300],)
    ),
    TabIconData(
      index: 2,
      isSelected: false,
      animationController: null,
      icon: Icon(Icons.tune, size: 40, color: Colors.black,),
      selectedIcon: Icon(Icons.tune, size: 40, color: Colors.green[300],)
    ),
    TabIconData(
      index: 3,
      isSelected: false,
      animationController: null,
      icon: Icon(Icons.error_outline, size: 40, color: Colors.black,),
      selectedIcon: Icon(Icons.error_outline, size: 40, color: Colors.green[300],)
    ),
  ];
}
