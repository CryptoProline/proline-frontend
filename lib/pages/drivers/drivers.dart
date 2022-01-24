import 'package:data_table_2/data_table_2.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:web_ui/constants/controllers.dart';
import 'package:web_ui/constants/style.dart';
import 'package:web_ui/helpers/responsiveness.dart';
import 'package:web_ui/mqtt/client.dart';
// import 'package:web_ui/mqtt/mqtt_client.dart';
import 'package:web_ui/pages/drivers/widgets/get_open_pools.dart';
import 'package:web_ui/pages/drivers/widgets/open_pool.dart';
import 'package:web_ui/widgets/custom_text.dart';

class DriversPage extends StatelessWidget {
  const DriversPage({ Key? key }) : super(key: key);
  @override
    Widget build(BuildContext context) {
      return Obx(() => Column(
        children: [
          Row(
            children: [
              Container(
                margin: EdgeInsets.only(
                  top: ResponsiveWidget.isSmallScreen(context) ? 56 : 6
                ),
                child: CustomText(
                  text: menuController.activeItem.value,
                  size: 24,
                  weight: FontWeight.bold,
                )
                
              )
            ],
          ),
          Expanded(
            child: ListView(
              children: openPools(),
            )
          ),
          InkWell(
            onTap: () => mqttTest(),
            child: Container(
              padding: const EdgeInsets.all(30),
              color:Colors.blue,
              child: Text("Send message")
            ),
          )
        ],
      ));
    }
}



void mqttTest() {
  print("Inside mqttTest");
  // var mqtt = MqttClient();
  // print("after mqtt");
  // mqtt.connect();  
  // var rest = AWSIotDevice();
  var mqtt = AWSIotDevice(endpoint: 'a10kgd1h6n9i0s-ats.iot.us-east-1.amazonaws.com', clientId:'pleaseworkplease');
  mqtt.connect();  

}