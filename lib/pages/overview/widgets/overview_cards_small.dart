import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:web_ui/constants/controllers.dart';
import 'package:web_ui/pages/overview/widgets/info_card.dart';
import 'package:web_ui/pages/overview/widgets/info_card_small.dart';

class OverviewCardsSmallScreen extends StatelessWidget {
  const OverviewCardsSmallScreen({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double _width = MediaQuery.of(context).size.width;
    return Container(
      height: 400,
      child: Column(
        children: [
          Obx(() => InfoCardSmall(
            title: "Number of Open Pools",
            value: poolsController.poolsList.value.length.toString(),
            onClick: (){},
            isActive: true,
          )),
          SizedBox(
            height: _width / 64,
          ),
          InfoCard(
            title: "Games Guessed Correctly",
            value: '0',
            onClick: (){},
            topColor: Colors.redAccent, isActive: false,
          ),
          SizedBox(
            height: _width / 64,
          ),
          InfoCard(
            title: "Total Winnings",
            value: "\$0.00",
            onClick: (){},
            isActive: false,
          ),
          SizedBox(
            height: _width / 64,
          ),
          InfoCardSmall(
            title: "Scheduled Deliveries",
            value: "32",
            onClick: (){},
            isActive: false,
          ),
        ],
      )
    );
  }
}