import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:web_ui/helpers/responsiveness.dart';
import 'package:web_ui/widgets/large_screen.dart';
import 'package:web_ui/widgets/side_menu.dart';
import 'package:web_ui/widgets/small_screen.dart';
import 'package:web_ui/widgets/top_nav.dart';

class SiteLayout extends StatelessWidget {
  GlobalKey<ScaffoldState> scaffoldKey = GlobalKey();

  // @override
  // Widget build(BuildContext context) {
  //   return Scaffold(
  //     key: scaffoldKey,
  //     extendBodyBehindAppBar: true,
  //     appBar: topNavigationBar(context, scaffoldKey),
  //     drawer: const Drawer(child: SideMenu()),
  //     body: const ResponsiveWidget(largeScreen: LargeScreen(), smallScreen: SmallScreen())
  //   );
  // }
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: SharedPreferences.getInstance(),
      builder: (BuildContext context, AsyncSnapshot<SharedPreferences> prefs) {
        if (prefs.hasData) {
          return Scaffold(
            key: scaffoldKey,
            extendBodyBehindAppBar: true,
            appBar: topNavigationBar(context, scaffoldKey, prefs.data),
            drawer: const Drawer(child: SideMenu()),
            body: const ResponsiveWidget(largeScreen: LargeScreen(), smallScreen: SmallScreen())
          );
        }
        else {
            return const Center(
              child: CircularProgressIndicator(),
            );
        }
      },
    );
  }
}