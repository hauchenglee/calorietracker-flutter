import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class TabIconData {
  TabIconData({
    this.iconData,
    this.index = 0,
    this.isSelected = false,
    this.animationController,
  });

  IconData? iconData; // 使用IconData类型
  int index;
  bool isSelected;
  AnimationController? animationController;

  static List<TabIconData> tabIconsList = <TabIconData>[
    TabIconData(
      // iconData: FontAwesomeIcons.house,
      iconData: Icons.home,
      index: 0,
      isSelected: true,
      animationController: null,
    ),
    TabIconData(
      iconData: FontAwesomeIcons.utensils,
      index: 1,
      isSelected: false,
      animationController: null,
    ),
    TabIconData(
      iconData: FontAwesomeIcons.bookOpen,
      index: 2,
      isSelected: false,
      animationController: null,
    ),
    TabIconData(
      iconData: FontAwesomeIcons.ellipsis,
      index: 3,
      isSelected: false,
      animationController: null,
    ),
  ];
}
