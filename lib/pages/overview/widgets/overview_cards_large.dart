import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:web_ui/constants/controllers.dart';
import 'package:web_ui/pages/overview/widgets/info_card.dart';

class OverviewCardsLargeScreen extends StatelessWidget {
  const OverviewCardsLargeScreen({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double _width = MediaQuery.of(context).size.width;
    return Row(
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
        InfoCard(
          title: "Games Guessed Correctly",
          value: '0',
          onClick: (){},
          topColor: Colors.redAccent, isActive: false,
        ),
        SizedBox(
          width: _width / 64,
        ),
        InfoCard(
          title: "Total Winnings",
          value: "\$0.00",
          onClick: (){},
          isActive: false,
        ),
        SizedBox(
          width: _width / 64,
        ),

      ],
    );
  }
}