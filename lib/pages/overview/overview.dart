import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:web_ui/constants/controllers.dart';
import 'package:web_ui/helpers/responsiveness.dart';
import 'package:web_ui/pages/overview/widgets/available_drivers.dart';
import 'package:web_ui/pages/overview/widgets/overview_cards_small.dart';
import 'package:web_ui/pages/overview/widgets/overview_cards_large.dart';
import 'package:web_ui/pages/overview/widgets/overview_cards_medium.dart';
import 'package:web_ui/widgets/custom_text.dart';

class OverViewPage extends StatelessWidget {
  const OverViewPage({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Obx(() => Row(
          children: [
            Container(
              margin: EdgeInsets.only(
                top: ResponsiveWidget.isSmallScreen(context) ? 56 : 6
              ),
              child: CustomText(
                text: menuController.activeItem.value,
                size: 24,
                weight: FontWeight.bold,
              )
              
            )
          ],
        )),
        Expanded(
          child: ListView(
            children: [
              if(ResponsiveWidget.isLargeScreen(context) || ResponsiveWidget.isMediumScreen(context))
                if(ResponsiveWidget.isCustomSize(context))
                  const OverviewCardsMediumScreenSize()
                else
                  const OverviewCardsLargeScreen()
              else 
                const OverviewCardsSmallScreen(),
              const AvailableDrivers()
              
            ],
          )
        )
      ],
    );
  }
}