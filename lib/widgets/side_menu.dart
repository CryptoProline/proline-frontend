import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:web_ui/constants/controllers.dart';
import 'package:web_ui/constants/style.dart';
import 'package:web_ui/helpers/responsiveness.dart';
import 'package:web_ui/pages/authentication/authentication.dart';
import 'package:web_ui/routing/routes.dart';
import 'package:web_ui/widgets/custom_text.dart';
import 'package:web_ui/widgets/side_menu_items.dart';

class SideMenu extends StatelessWidget {
  const SideMenu({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double _width = MediaQuery.of(context).size.width;
    return Container(
      color: light,
      child: ListView(
        children: [
          if(ResponsiveWidget.isSmallScreen(context))
            Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const SizedBox(height: 40,),
                Row(
                  children: [
                    SizedBox(width: _width/48,),
                    Padding(
                      padding: const EdgeInsets.only(right:12),
                      child: Image.asset('icons/logo.png'),
                    ),
                    Flexible(
                      child: CustomText(
                        text: "CrpytoProline",
                        size:20,
                        weight: FontWeight.bold,
                        color:active
                      ),
                    ),
                    SizedBox(width: _width/48,)
                  ],
                ),
              ],
            ),
            const SizedBox(height: 40,),
            Divider(color: lightGrey.withOpacity(0.1),),
            Column(
              mainAxisSize: MainAxisSize.min,
              children: sideMenuItems.map((item) => SideMenuItem(
                itemName: item.name, 
                onClick: (){
                  if(item.route == AuthenticationPageRoute) {
                    menuController.changeActiveItemTo(OverViewPageDisplayName);
                    Get.offAllNamed(AuthenticationPageRoute);
                    // Get.offAll(() => AuthenticationPage());
                  }
                  if(!menuController.isActive(item.name)) {
                    menuController.changeActiveItemTo(item.name);
                    if(ResponsiveWidget.isSmallScreen(context)){
                      Get.back();}
                    navigationController.navigateTo(item.route);
                  }
                })).toList(),
            )
        ],
      ),
    );
  }
}