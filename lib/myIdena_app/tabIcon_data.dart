import 'package:flutter/material.dart';

class TabIconData {
  TabIconData({
    this.imagePath = '',
    this.index = 0,
    this.selectedImagePath = '',
    this.isSelected = false,
    this.animationController,
    this.icon,
    this.selectedIcon
  });

  String imagePath;
  String selectedImagePath;
  bool isSelected;
  int index;
  Icon icon;
  Icon selectedIcon;

  AnimationController animationController;

  static List<TabIconData> tabIconsList = <TabIconData>[
    TabIconData(
      imagePath: 'assets/images/tab_1.png',
      selectedImagePath: 'assets/images/tab_1s.png',
      index: 0,
      isSelected: true,
      animationController: null,
      icon: Icon(Icons.home, size: 40, color: Colors.black,),
      selectedIcon: Icon(Icons.home, size: 40, color: Colors.green[300],)
    ),
    TabIconData(
      imagePath: 'assets/images/tab_2.png',
      selectedImagePath: 'assets/images/tab_2s.png',
      index: 1,
      isSelected: false,
      animationController: null,
      icon: Icon(Icons.burst_mode, size: 40, color: Colors.black,),
      selectedIcon: Icon(Icons.burst_mode, size: 40, color: Colors.green[300],)
    ),
    TabIconData(
      imagePath: 'assets/images/tab_3.png',
      selectedImagePath: 'assets/images/tab_3s.png',
      index: 2,
      isSelected: false,
      animationController: null,
      icon: Icon(Icons.av_timer, size: 40, color: Colors.black,),
      selectedIcon: Icon(Icons.av_timer, size: 40, color: Colors.green[300],)
    ),
    TabIconData(
      imagePath: 'assets/images/tab_4.png',
      selectedImagePath: 'assets/images/tab_4s.png',
      index: 3,
      isSelected: false,
      animationController: null,
      icon: Icon(Icons.contacts, size: 40, color: Colors.black,),
      selectedIcon: Icon(Icons.contacts, size: 40, color: Colors.green[300],)
    ),
  ];
}
