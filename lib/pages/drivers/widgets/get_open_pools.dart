


import 'package:flutter/material.dart';
import 'package:web_ui/constants/controllers.dart';
import 'package:web_ui/pages/drivers/widgets/open_pool.dart';

List<OpenPool> openPools(){
  List<OpenPool> listOfPools = [];
  poolsController.mapMatchRow.value.forEach((key, value) {
    listOfPools.add(OpenPool(poolName:key, dataRow:value));
  });
  return listOfPools;
}