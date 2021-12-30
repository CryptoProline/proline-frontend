  import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:web_ui/constants/controllers.dart';
import 'package:web_ui/constants/style.dart';
import 'package:web_ui/models/pools_model.dart';
import 'package:web_ui/widgets/custom_text.dart';

List<DataRow> fetchPoolsData(List<Datum> pools) {
    var x =  DataCell(
      Container(
          decoration: BoxDecoration(
            color: light,
            borderRadius: BorderRadius.circular(20),
            border: Border.all(color: active, width: .5),
          ),
          padding: const EdgeInsets.symmetric(
              horizontal: 12, vertical: 6),
          child: CustomText(
            text: "View Pool",
            color: active.withOpacity(.7),
            weight: FontWeight.bold,
      )));
    List<DataRow> availablePools = pools.map((pool) {
      List<DataCell> l = [];
      var sport = pool.sportType;
      var numOfGames = pool.numOfGames;
      var poolStatus = pool.poolStatus;
      var startDate = pool.startDate;
      var endDate = pool.endDate;
      var startDateString = DateFormat("MMMMEEEEd").format(DateTime.fromMillisecondsSinceEpoch(startDate)); 
      var endDateString = DateFormat("MMMMEEEEd").format(DateTime.fromMillisecondsSinceEpoch(endDate)); 
      l.addAll([DataCell(CustomText(text: '$sport')), DataCell(CustomText(text: '$numOfGames')), DataCell(CustomText(text: '$poolStatus')), DataCell(CustomText(text: '$startDateString')), DataCell(CustomText(text: '$endDateString')), x]);
      return DataRow(cells:l);
    }).toList();
    // poolsController.updateOpenPoolData(availablePools);
    return availablePools;
  }