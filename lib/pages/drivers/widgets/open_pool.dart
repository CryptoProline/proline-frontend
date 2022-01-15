import 'package:data_table_2/data_table_2.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:web_ui/constants/controllers.dart';
import 'package:web_ui/constants/style.dart';
import 'package:web_ui/helpers/responsiveness.dart';
import 'package:web_ui/widgets/custom_text.dart';


import 'package:progress_state_button/iconed_button.dart';
import 'package:progress_state_button/progress_button.dart';

import 'package:percent_indicator/percent_indicator.dart';

class OpenPool extends StatelessWidget {
  final List<DataRow> dataRow;
  final String poolName;
  const OpenPool({ Key? key, required this.poolName, required this.dataRow}) : super(key: key);
  @override
    Widget build(BuildContext context) {
      double _width = MediaQuery.of(context).size.width;
      return Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Expanded(
            child: Container(
              margin: EdgeInsets.only(bottom:30, right: _width /64),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(8),
                // border: Border(top: BorderSide(color: Colors.orange, width: 3)),
                // border: Border.all(color: Colors.orange, width: 3),
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
                        // decoration: BoxDecoration(borderRadius: BorderRadius.circular(10), color: Colors.green),
                        // dividerThickness: 5,
                        dataRowHeight: 70,
                        columnSpacing: 12,
                        horizontalMargin: 12, 
                        // minWidth: 600,
                        columns: const [
                          DataColumn2(
                            label: Text('Date'),
                            // size: ColumnSize.L,
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
                
                  // Obx(() => Text(poolsController.poolSelectionCount.value[poolName].toString())),
                  // Text(poolsController.getTotalGames(poolName)),
                  
                ],
              ),
            ),
          ),
          Container(
            margin: EdgeInsets.only(bottom:30, right: _width /64),
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
            width:300,
            height:550,
            child: Column(
              children: [
                const SizedBox(height:40),
                SizedBox(
                  width:170,
                  height:170,
                  child: Obx(() => CircularPercentIndicator(
                    radius:170,
                    lineWidth: 18.0,
                    backgroundColor: Colors.grey[350]!,
                    percent: poolsController.getTotalGames(poolName),
                    circularStrokeCap: CircularStrokeCap.round,
                    animation:true,
                    animateFromLastPercent: true,
                    animationDuration: 300,
                    progressColor: Colors.green,
                  ))
                ),
                const SizedBox(height:40,),
                Obx(() => Container(
                  width:230,
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(color: poolsController.checkIfSelectionStarted(poolName) ? Colors.green : Colors.grey[350]!, width: 1.5)
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      CustomText(
                        text: "Home Games",
                        size: 20,
                        weight: FontWeight.w300,
                        color: poolsController.checkIfSelectionStarted(poolName) ? Colors.green : Colors.grey[350]!
                      ),
                      CustomText(
                        text: poolsController.poolBettingStats.value[poolName]!['home'].toString(),
                        size: 20,
                        weight: FontWeight.bold,
                        color: poolsController.checkIfSelectionStarted(poolName) ? Colors.green : Colors.grey[350]!
                      )
                    ],
                  )
                )),
                const SizedBox(height:10,),                
                Obx(() => Container(
                  width:230,
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(color: poolsController.checkIfSelectionStarted(poolName) ? Colors.green : Colors.grey[350]!, width: 1.5)
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      CustomText(
                        text: "Box Games",
                        size: 20,
                        weight: FontWeight.w300,
                        color: poolsController.checkIfSelectionStarted(poolName) ? Colors.green : Colors.grey[350]!
                      ),
                      CustomText(
                        text: poolsController.poolBettingStats.value[poolName]!['box'].toString(),
                        size: 20,
                        weight: FontWeight.bold,
                        color: poolsController.checkIfSelectionStarted(poolName) ? Colors.green : Colors.grey[350]!
                      )
                    ],
                  )
                )),     
                const SizedBox(height:10,),                
                Obx(() => Container(
                  width:230,
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(color: poolsController.checkIfSelectionStarted(poolName) ? Colors.green : Colors.grey[350]!, width: 1.5)
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      CustomText(
                        text: "Away Games",
                        size: 20,
                        weight: FontWeight.w300,
                        color: poolsController.checkIfSelectionStarted(poolName) ? Colors.green : Colors.grey[350]!
                      ),
                      CustomText(
                        text: poolsController.poolBettingStats.value[poolName]!['away'].toString(),
                        size: 20,
                        weight: FontWeight.bold,
                        color: poolsController.checkIfSelectionStarted(poolName) ? Colors.green : Colors.grey[350]!
                      )
                    ],
                  )
                )),    
                const SizedBox(height:40),      
              Obx(() => ProgressButton.icon(iconedButtons: {
                ButtonState.idle:
                  IconedButton(
                      text: "Place Bet",
                      icon: Icon(Icons.send,color: Colors.white),
                      color: poolsController.checkTotal(poolName, poolsController.poolSelectionCount.value[poolName]!) ? Colors.deepPurple.shade500 : Colors.grey[350]!
                    ),
                ButtonState.loading:
                  IconedButton(
                      text: "Loading",
                      color: Colors.deepPurple.shade700),
                ButtonState.fail:
                  IconedButton(
                      text: "Failed",
                      icon: Icon(Icons.cancel,color: Colors.white),
                      color: Colors.red.shade300),
                ButtonState.success:
                  IconedButton(
                      text: "Redirected",
                      icon: Icon(Icons.check_circle,color: Colors.white,),
                      color: Colors.green.shade400)
                }, 
                onPressed: (){
                  if(poolsController.checkTotal(poolName, poolsController.poolSelectionCount.value[poolName]!)){
                    poolsController.buttonState.value = ButtonState.loading;
                    poolsController.createBet(poolName);
                  } 
                },
                state: poolsController.buttonState.value))
              ],
            )
          )
        ],
      );
  }
}