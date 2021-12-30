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
  

  var mapMatchRow = <String, List<DataRow>>{}.obs;

  var mapB = <String, Map<String, String>>{}.obs;


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

  // void updateOpenPoolData(List<DataRow> availablePools) => poolsRow.value = availablePools;
  


  void fetchPoolData(List<Datum> pools) async {
    List<List<DataRow>> availablePools = pools.map((pool) {
      List<DataRow> matchRow = pool.matches.map((match) {
        List<DataCell> matchCells = [];
        var matchDate = match.date;
        var matchDateString = DateFormat('MMMMEEEEd').format(DateTime.parse(matchDate)); 
        var matchTimeString = DateFormat('jm').format(DateTime.parse(matchDate)); 
        var matchDateTime = "$matchTimeString, $matchDateString";
        var away = match.away;
        var home = match.home;
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
                  onTap: () => poolsController.changeButton(home, away, "home"),
                  child:  Container(
                      decoration: BoxDecoration(
                        color: light,
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(color: poolsController.checkButton(home, away, "home") ? active: Colors.grey, width: .5),
                      ),
                      padding: const EdgeInsets.symmetric(
                          horizontal: 12, vertical: 6),
                      child: CustomText(
                        text: "Home",
                        color: poolsController.checkButton(home, away, "home") ? active: Colors.grey.withOpacity(.7),
                        weight: FontWeight.bold,
                  )),
                ),
                const SizedBox(width: 5,),
                InkWell(
                  onTap: () => poolsController.changeButton(home, away, "box"),
                  child: Container(
                      decoration: BoxDecoration(
                        color: light,
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(color: poolsController.checkButton(home, away, "box") ? active: Colors.grey, width: .5),
                      ),
                      padding: const EdgeInsets.symmetric(
                          horizontal: 12, vertical: 6),
                      child: CustomText(
                        text: "Box",
                        color: poolsController.checkButton(home, away, "box") ? active: Colors.grey.withOpacity(.7),
                        weight: FontWeight.bold,
                  )),
                ),
                const SizedBox(width: 5,),
                InkWell(
                  onTap: () => poolsController.changeButton(home, away, "away"),
                  child: Container(
                      decoration: BoxDecoration(
                        color: light,
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(color: poolsController.checkButton(home, away, "away") ? active: Colors.grey, width: .5),
                      ),
                      padding: const EdgeInsets.symmetric(
                          horizontal: 12, vertical: 6),
                      child: CustomText(
                        text: "Away",
                        color: poolsController.checkButton(home, away, "away") ? active: Colors.grey.withOpacity(.7),
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

  void changeButton(String home, String away, String change) {
    mapBet.value['$home$away'] = change;
    mapBet.refresh();
  }

  bool checkButton(String home, String away, String value) {
    if (mapBet.value['$home$away'] != value) {
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