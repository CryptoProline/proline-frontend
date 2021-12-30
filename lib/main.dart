import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:web_ui/constants/style.dart';
import 'package:web_ui/controllers/menu_controller.dart';
import 'package:web_ui/controllers/navigation_controller.dart';
import 'package:web_ui/injector/injector.dart';
import 'package:web_ui/layout.dart';
import 'package:web_ui/pages/404/error_page.dart';
import 'package:web_ui/pages/authentication/authentication.dart';
import 'package:web_ui/pages/authentication/token.dart';
import 'package:web_ui/routing/routes.dart';
import 'package:url_strategy/url_strategy.dart';

import 'controllers/pools_controller.dart';

Future<void> main() async {
  await dotenv.load(fileName: "../environment/local.env");
  setPathUrlStrategy();
  await setupLocator();
  Get.put(MenuController());
  Get.put(NavigationController());
  Get.put(PoolsController());
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      initialRoute: AuthenticationPageRoute,
      unknownRoute: GetPage(
        name: '/not-found', 
        page: () => PageNotFound(), 
        transition: Transition.fadeIn
      ),
      getPages: [
        GetPage(
          name: RootRoute, 
          page: () => SiteLayout()
        ),
        GetPage(
          name: '/callback', 
          page: () => PageTokenStateful()
        ),
        GetPage(name: AuthenticationPageRoute, page: () => const AuthenticationPage()),
      ],
      debugShowCheckedModeBanner: false,
      title: 'Dash',
      theme: ThemeData(
        scaffoldBackgroundColor: light,
        textTheme: GoogleFonts.mulishTextTheme(
          Theme.of(context).textTheme
        ).apply(
          bodyColor: Colors.black
        ),
        pageTransitionsTheme: const PageTransitionsTheme(builders: {
          TargetPlatform.iOS:  FadeUpwardsPageTransitionsBuilder(),
          TargetPlatform.android: FadeUpwardsPageTransitionsBuilder()
        }),
        primaryColor: Colors.blue
      ),
      home: const AuthenticationPage(),
      // home: SiteLayout(),
    );
  }
}
