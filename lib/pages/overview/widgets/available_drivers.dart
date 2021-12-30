import 'package:data_table_2/data_table_2.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:web_ui/constants/controllers.dart';
import 'package:web_ui/constants/style.dart';
import 'package:web_ui/pages/overview/widgets/pools_data_row.dart';
import 'package:web_ui/widgets/custom_text.dart';
import 'package:web_ui/controllers/pools_controller.dart';
import 'package:get/get.dart';

/// Example without a datasource
class AvailableDrivers extends StatelessWidget {
  const AvailableDrivers();

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
      child: Obx(() =>  Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            children: [
              const SizedBox(
                width: 10,
              ),
              CustomText(
                text: "Available Pools",
                color: lightGrey,
                weight: FontWeight.bold,
              )
            ]
          ),
          DataTable2(
            columnSpacing: 12,
            horizontalMargin: 12,
            minWidth: 600,
            columns: const [
              DataColumn2(
                label: Text('Sport'),
                size: ColumnSize.L,
              ),
              DataColumn(
                label: Text('Number of Games'),
              ),
              DataColumn(
                label: Text('Status'),
              ),
              DataColumn(
                label: Text('Start Date'),
              ),
              DataColumn(
                label: Text('End Date'),
              ),
              DataColumn(
                label: Text('View Pools'),
              ),
            ],
            rows: fetchPoolsData(poolsController.poolsList.value)
            // rows: poolsController.poolsRow.value
          )],
      )),
    );
  }
}