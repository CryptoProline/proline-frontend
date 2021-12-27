import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:web_ui/constants/controllers.dart';
import 'package:web_ui/pages/overview/widgets/info_card.dart';

class OverviewCardsMediumScreenSize extends StatelessWidget {
  const OverviewCardsMediumScreenSize({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double _width = MediaQuery.of(context).size.width;
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Row(
          children: [
            Obx(() => InfoCard(
                title: "Number Of Open Pools",
                value: poolsController.poolsList.value.length.toString(),
              onClick: (){},
              topColor: Colors.orange, isActive: false,
            )),
            SizedBox(
              width: _width / 64,
            ),
            InfoCard(
              title: "Bets Placed",
              value: "0",
              onClick: (){},
              topColor: Colors.lightGreen, isActive: false,
            ),
            SizedBox(
              width: _width / 64,
            ),
          ],
        ),
        const SizedBox(height: 16),
        Row(
          children: [
            InfoCard(
              title: "Cancelled Delivery",
              value: "3",
              onClick: (){},
              topColor: Colors.redAccent, isActive: false,
            ),
            SizedBox(
              width: _width / 64,
            ),
            InfoCard(
              title: "Scheduled Deliveries",
              value: "32",
              onClick: (){},
              isActive: false,
            ),
            SizedBox(
              width: _width / 64,
            ),
          ],
        )
      ],
    );
  }
}