import 'package:flutter/material.dart';
import 'package:web_ui/constants/style.dart';
import 'package:web_ui/helpers/responsiveness.dart';
import 'package:web_ui/widgets/custom_text.dart';

AppBar topNavigationBar(BuildContext context, GlobalKey<ScaffoldState> key) => 
  AppBar(
    backgroundColor: Colors.transparent,
    iconTheme: IconThemeData(color:dark),
    leading: !ResponsiveWidget.isSmallScreen(context) ? 
    Row(
      children: [
        Container(
          padding: const EdgeInsets.only(left:14),
          child: Image.asset('icons/logo.png', width: 28,)
        )
      ],
    ) : IconButton(
      icon: const Icon(Icons.menu, color: Colors.black),
      onPressed: () {
        key.currentState?.openDrawer();
      },
    ),
    elevation:0,
    title: Row(
      children: [
        Visibility(
          child: CustomText(
            text: "CryptoProline",
            color: lightGrey,
            size: 20,
            weight: FontWeight.bold
          ),
        ),
        Expanded(child: Container(),),
        IconButton(
          icon: Icon(Icons.settings, color: dark.withOpacity(0.7)),
          onPressed: null,
        ),
        Stack(
          children: [
            IconButton(
              icon: Icon(Icons.notifications, color: dark.withOpacity(0.7)),
              onPressed: null,
            ),
            Positioned(
              top:7,
              right:7,
              child: Container(
                width:12,
                height: 12,
                padding: const EdgeInsets.all(4),
                decoration: BoxDecoration(
                  color:active,
                  borderRadius: BorderRadius.circular(30),
                  border: Border.all(color:light, width: 2)
                ),
              )
            )
          ],
        ),
        Container(
          width: 1,
          height:22,
          color: lightGrey
        ),
        const SizedBox(width:24),
        CustomText(text: "Santos Enoque", color: lightGrey),
        const SizedBox(width:16),
        Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(30),
          ),
          child: Container(
            padding: const EdgeInsets.all(2),
            margin: const EdgeInsets.all(2),
            child: CircleAvatar(
              backgroundColor: light,
              child: Icon(Icons.person_outline, color: dark,),
            ),
          ),
        )
      ],
    ),
  );