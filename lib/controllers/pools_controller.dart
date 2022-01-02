import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:web_ui/api/api_client.dart';
import 'package:web_ui/constants/controllers.dart';
import 'package:web_ui/constants/style.dart';
import 'package:web_ui/models/pools_model.dart';
import 'package:web_ui/widgets/custom_text.dart';
// import 'package:intl/intl_browser.dart';
import 'package:http/http.dart' as http;


class PoolsController extends GetxController {
  static PoolsController instance = Get.find();
  var poolsList = <Datum>[].obs;
  // var poolsRow = <DataRow>[].obs;

  var matchRow = <List<DataRow>>[].obs;

  var listBet = <String>[].obs;

  var mapBet = <String, String>{}.obs;
  // var mapBet = <String, String>{}.obs;
  

  var mapMatchRow = <String, List<DataRow>>{}.obs;

  var mapB = <String, Map<String, String>>{}.obs;

  var poolSelectionCount = <String, int>{}.obs;


  // var betOption = <List>

  @override
  void onInit() {
    fetchOpenPools();
    super.onInit();
  }

  void fetchOpenPools() async {

    var pools = await ApiClient.getOpenPools();
    // fetchPoolsData(pools.data);
    fetchPoolData(pools.data);
    poolsList.value = pools.data;
  }

  bool checkTotal(String poolName, int numSelected){
    bool check = false;
    poolsList.value.forEach((pool) {
      if(pool.sportType == poolName) {
        if(pool.numOfGames == numSelected) {
          check = true;
        }
      }
    });
    return check;
  } 


  void createBet(String poolName) {
    mapB.value[poolName]!.forEach((key, value) {
      print("$key : $value");
    });
  }

  // void updateOpenPoolData(List<DataRow> availablePools) => poolsRow.value = availablePools;
  


  void fetchPoolData(List<Datum> pools) async {
    List<List<DataRow>> availablePools = pools.map((pool) {
      List<DataRow> matchRow = pool.matches.map((match) {
        List<DataCell> matchCells = [];
        var poolType = pool.sportType;
        poolSelectionCount.value['$poolType'] = 0;
        var matchDate = match.date;
        var matchDateString = DateFormat('MMMMEEEEd').format(DateTime.parse(matchDate)); 
        var matchTimeString = DateFormat('jm').format(DateTime.parse(matchDate)); 
        var matchDateTime = "$matchTimeString, $matchDateString";
        var away = match.away;
        var home = match.home;
        var matchId = match.id;
        // mapBet.value['$home$away'] = 'none';
        matchCells.addAll([
          DataCell(CustomText(text: '$matchDateTime')), 
          DataCell(CustomText(text: '$away')), 
          DataCell(CustomText(text: '$home'),),
          // betCell,
          DataCell(
           Obx(() =>  Row(
              children: [
                InkWell(
                  onTap: () => poolsController.changeButton(matchId, "home",poolType),
                  child:  Container(
                      decoration: BoxDecoration(
                        color: light,
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(color: poolsController.checkButton(matchId, "home", poolType) ? active: Colors.grey, width: .5),
                      ),
                      padding: const EdgeInsets.symmetric(
                          horizontal: 12, vertical: 6),
                      child: CustomText(
                        text: "Home",
                        color: poolsController.checkButton(matchId, "home", poolType) ? active: Colors.grey.withOpacity(.7),
                        weight: FontWeight.bold,
                  )),
                ),
                const SizedBox(width: 5,),
                InkWell(
                  onTap: () => poolsController.changeButton(matchId, "box", poolType),
                  child: Container(
                      decoration: BoxDecoration(
                        color: light,
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(color: poolsController.checkButton(matchId, "box", poolType) ? active: Colors.grey, width: .5),
                      ),
                      padding: const EdgeInsets.symmetric(
                          horizontal: 12, vertical: 6),
                      child: CustomText(
                        text: "Box",
                        color: poolsController.checkButton(matchId, "box", poolType) ? active: Colors.grey.withOpacity(.7),
                        weight: FontWeight.bold,
                  )),
                ),
                const SizedBox(width: 5,),
                InkWell(
                  onTap: () => poolsController.changeButton(matchId, "away", poolType),
                  child: Container(
                      decoration: BoxDecoration(
                        color: light,
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(color: poolsController.checkButton(matchId, "away", poolType) ? active: Colors.grey, width: .5),
                      ),
                      padding: const EdgeInsets.symmetric(
                          horizontal: 12, vertical: 6),
                      child: CustomText(
                        text: "Away",
                        color: poolsController.checkButton(matchId, "away", poolType) ? active: Colors.grey.withOpacity(.7),
                        weight: FontWeight.bold,
                  )),
                ),
              ],
            ))
          )
        ]);
        return DataRow(cells: matchCells,);
      }).toList();
      mapMatchRow.value[pool.sportType] = matchRow;
      return matchRow;
    }).toList();
    matchRow.value = availablePools;
  }

  void changeButton(String matchId, String change, String poolType) { 

    // mapB[poolType]![matchId] = "json";
    if(mapB.value[poolType] == null) {
      mapB.value[poolType] = new Map();
    }
    if(mapB.value[poolType]![matchId] == null) {
      poolSelectionCount.value['$poolType'] = poolSelectionCount.value['$poolType']! + 1;
    }

    mapB.value[poolType] = {...mapB.value[poolType]!, matchId:change};
    mapB.refresh();
    poolSelectionCount.refresh();
  }

  bool checkButton(String matchId, String value, String poolType) {
    if(mapB.value[poolType] == null) {
      return false;
    }
    if (mapB[poolType]![matchId]  != value) {
      return false;
    } else {
      return true;
    }
  }

  int numberSelected(String sportType) {
    var count = 0;
    mapBet.forEach((key, value) { 
      if(value == "home" || value == "away" || value == "box"){
        count = count+1;
      }
    });
    return count;
  }

}