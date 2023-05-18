import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:traders_builders_partner/TBTraders/TraderBookings.dart';
import 'package:traders_builders_partner/TBTraders/TraderGetStarted.dart';
import 'package:traders_builders_partner/TBTraders/TraderLogin.dart';
import 'package:traders_builders_partner/shared/TBAppColors.dart';
import 'TBTraders/TraderForgotPassword.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
 Widget initialScreen = TraderLogin();

  @override
  void initState() {
    super.initState();
    isTraderLoggedIn();
  }

  isTraderLoggedIn() async {
    final sharedPreferences = await SharedPreferences.getInstance();
    final traderId = sharedPreferences.getInt('trader_id');
    if (traderId == null) {
      //print("TRADER_ID is null");
      setState(() {
        initialScreen = const TraderLogin();
      });
    } else {
      //print("TRADER_ID:"+traderId.toString());
      setState(() {
        initialScreen = const TraderBookings();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
          primarySwatch: Palette.kToDark,
          inputDecorationTheme: InputDecorationTheme(
              border:
              OutlineInputBorder(borderRadius: BorderRadius.circular(8))),
          outlinedButtonTheme: OutlinedButtonThemeData(
              style: OutlinedButton.styleFrom(
                  minimumSize: Size.fromHeight(50),
                  backgroundColor: Palette.appSecondaryDark,
                  primary: Colors.black)),
          scaffoldBackgroundColor: Palette.appPrimaryLight),
      home: initialScreen,
      routes: {
        '/login': (context) => const TraderLogin(),
        '/forgotPassword': (context) => const TraderForgotPassword(),
        '/registration': (context) => const TraderGetStarted(),
      },
    );
  }
}
