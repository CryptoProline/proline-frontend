import 'package:data_table_2/data_table_2.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:web_ui/constants/controllers.dart';
import 'package:web_ui/constants/style.dart';
import 'package:web_ui/helpers/responsiveness.dart';
import 'package:web_ui/widgets/custom_text.dart';

class OpenPool extends StatelessWidget {
  final List<DataRow> dataRow;
  final String poolName;
  const OpenPool({ Key? key, required this.poolName, required this.dataRow}) : super(key: key);
  @override
    Widget build(BuildContext context) {
      double _width = MediaQuery.of(context).size.width;
      return Container(
        margin: EdgeInsets.only(bottom:30, top:30, right: _width /64),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(8),
          boxShadow: [
            BoxShadow(
              offset: const Offset(0,6),
              color: lightGrey.withOpacity(0.1),
              blurRadius: 12,
            )
          ]
        ),
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              children: [
                const SizedBox(
                  width: 10,
                ),
                CustomText(
                  text: "${poolName} Pool",
                  color: lightGrey,
                  weight: FontWeight.bold,
                )
              ]
            ),
            SingleChildScrollView(
              child: SizedBox(
                height: 500,
                child: DataTable2(
                  columnSpacing: 12,
                  horizontalMargin: 12,
                  minWidth: 600,
                  columns: const [
                    DataColumn2(
                      label: Text('Date'),
                      size: ColumnSize.L,
                    ),
                    DataColumn(
                      label: Text('Away'),
                    ),
                    DataColumn(
                      label: Text('Home'),
                    ),
                    DataColumn(
                      label: Text('Bet'),
                    ),
                  ],
                  rows: dataRow
                ),
              ),
            ),
            Obx(() => Text(poolsController.poolSelectionCount.value[poolName].toString())),
            Obx(() => InkWell(
              onTap: () => poolsController.createBet(poolName),
              child:  Container(
                  decoration: BoxDecoration(
                    color: light,
                    borderRadius: BorderRadius.circular(15),
                    border: Border.all(color: poolsController.checkTotal(poolName, poolsController.poolSelectionCount.value[poolName]!) ? active: Colors.grey, width: .5),
                  ),
                  padding: const EdgeInsets.symmetric(
                      horizontal: 24, vertical: 12),
                  child: CustomText(
                    text: "Place Bet",
                    color: poolsController.checkTotal(poolName, poolsController.poolSelectionCount.value[poolName]!) ? active: Colors.grey.withOpacity(.7),
                    weight: FontWeight.bold,
              )),
            )),
          ],
        ),
      );
  }
}