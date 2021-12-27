import 'package:flutter/material.dart';
import 'package:web_ui/constants/controllers.dart';
import 'package:web_ui/routing/router.dart';
import 'package:web_ui/routing/routes.dart';

Navigator localNavigator() => Navigator(
  key: navigationController.navigationKey,
  initialRoute: OverViewPageRoute,
  onGenerateRoute: generateRoute,
);