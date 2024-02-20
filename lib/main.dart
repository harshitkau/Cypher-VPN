import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:vpn_basic_project/helpers/pref.dart';
import 'package:vpn_basic_project/screens/splash_screen.dart';
// import 'screens/home_screen.dart';

late Size mq;
Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  //for full screen mode
  SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersive);

  await Pref.initializeHive();
  // for lock the orientation
  SystemChrome.setPreferredOrientations(
          [DeviceOrientation.portraitDown, DeviceOrientation.portraitUp])
      .then((value) => runApp(const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      theme:
          ThemeData(appBarTheme: AppBarTheme(centerTitle: true, elevation: 7)),
      darkTheme: ThemeData(
          brightness: Brightness.dark,
          appBarTheme: AppBarTheme(centerTitle: true, elevation: 7)),
      themeMode: Pref.isDarkMode ? ThemeMode.dark : ThemeMode.light,
      title: 'Cypher VPN',
      home: SplashScreen(),
    );
  }
}

extension AppTheme on ThemeData {
  Color get lightText => Pref.isDarkMode ? Colors.white70 : Colors.black54;
  Color get bottomNav =>
      Pref.isDarkMode ? Colors.white10 : Color.fromRGBO(0, 53, 85, 1);
  Color get spacescr =>
      Pref.isDarkMode ? Colors.white : Color.fromRGBO(0, 53, 85, 1);
  // Color get bottomNav => Pref.isDarkMode ? Colors.white10 : Colors.blue;
  Color get blackTheme => Pref.isDarkMode ? Colors.white : Colors.black;
  Color get networkTheme =>
      Pref.isDarkMode ? const Color.fromARGB(26, 93, 88, 88) : Colors.white;
}
