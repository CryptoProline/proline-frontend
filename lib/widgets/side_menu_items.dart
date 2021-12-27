import 'package:flutter/material.dart';
import 'package:web_ui/helpers/responsiveness.dart';
import 'package:web_ui/widgets/horizontal_menu_item.dart';
import 'package:web_ui/widgets/vertical_menu_item.dart';

class SideMenuItem extends StatelessWidget {
  final String itemName;
  final VoidCallback onClick;
  const SideMenuItem({ Key? key, required this.itemName, required this.onClick }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if(ResponsiveWidget.isCustomSize(context)) {
      return VerticalMenuItem(itemName: itemName, onClick: onClick);
    }
    return HorizontalMenuItem(itemName: itemName, onClick: onClick);
  }
}