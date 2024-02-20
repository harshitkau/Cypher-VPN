import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:vpn_basic_project/main.dart';
import 'package:vpn_basic_project/screens/home_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Future.delayed(Duration(milliseconds: 2500), () {
      //to exit full screen
      SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge);
      Get.off(() => HomeScreen());
      // Navigator.pushReplacement(
      // context, MaterialPageRoute(builder: (_) => HomeScreen()));
    });
  }

  @override
  Widget build(BuildContext context) {
    mq = MediaQuery.of(context).size;
    return Scaffold(
        // backgroundColor: Color.fromRGBO(0, 53, 85, 1),
        body: Stack(
      children: [
        Positioned(
          left: mq.width * 0.25,
          top: mq.height * 0.3,
          width: mq.width * 0.5,
          child: Image.asset(
            'assets/image/shield.png',
          ),
        ),
        Positioned(
          bottom: mq.height * 0.3,
          width: mq.width,
          child: Text(
            "Cypher VPN",
            textAlign: TextAlign.center,
            style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Theme.of(context).spacescr,
                letterSpacing: 1.5,
                fontSize: 30),
          ),
        )
      ],
    ));
  }
}
