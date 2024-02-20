import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vpn_basic_project/controllers/home_controller.dart';
import 'package:vpn_basic_project/helpers/pref.dart';
import 'package:vpn_basic_project/models/vpn_status.dart';
import 'package:vpn_basic_project/screens/location_screen.dart';
import 'package:vpn_basic_project/screens/network_test_screen.dart';
import 'package:vpn_basic_project/widgets/count_down_timer.dart';
import 'package:vpn_basic_project/widgets/home_card.dart';
import '../main.dart';
import '../services/vpn_engine.dart';

class HomeScreen extends StatelessWidget {
  final _controller = Get.put(HomeController());

  @override
  Widget build(BuildContext context) {
    // mq = MediaQuery.of(context).size;
    VpnEngine.vpnStageSnapshot().listen((event) {
      _controller.vpnState.value = event;
    });

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).bottomNav,
        leading: IconButton(
            onPressed: () {
              Get.changeThemeMode(
                  Pref.isDarkMode ? ThemeMode.light : ThemeMode.dark);

              Pref.isDarkMode = !Pref.isDarkMode;
            },
            icon: Icon(
              Icons.brightness_medium,
              size: 26,
              color: Colors.white,
            )),
        title: Text(
          'Cypher VPN',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.w600),
        ),
        actions: [
          IconButton(
              padding: EdgeInsets.only(right: 8),
              onPressed: () => Get.to(NetworkTestScreen()),
              icon: Icon(
                CupertinoIcons.info,
                size: 27,
                color: Colors.white,
              )),
        ],
      ),
      bottomNavigationBar: _changelocation(context),
      body: Column(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
        SizedBox(
          height: mq.height * 0.02,
          width: double.maxFinite,
        ),
        Obx(() => _vpnButton(context)),
        Obx(
          () => Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              HomeCard(
                  title: _controller.vpn.value.countryLong.isEmpty
                      ? "NA"
                      : _controller.vpn.value.countryLong,
                  subtitle: "Country",
                  icon: CircleAvatar(
                      radius: 30,
                      child: _controller.vpn.value.countryLong.isEmpty
                          ? Icon(
                              Icons.vpn_lock_outlined,
                              size: 30,
                            )
                          : null,
                      backgroundImage: _controller.vpn.value.countryLong.isEmpty
                          ? null
                          : AssetImage(
                              'assets/flags/${_controller.vpn.value.countryShort.toLowerCase()}.png'))),
              HomeCard(
                  title: _controller.vpn.value.countryLong.isEmpty
                      ? "NA"
                      : _controller.vpn.value.ping + ' ms',
                  subtitle: "PING",
                  icon: CircleAvatar(
                    radius: 30,
                    backgroundColor: Colors.orange,
                    child: Icon(
                      Icons.equalizer,
                      size: 30,
                      color: Colors.white,
                    ),
                  )),
            ],
          ),
        ),
        // SizedBox(height: mq.height * 0.02),
        StreamBuilder<VpnStatus?>(
            initialData: VpnStatus(),
            stream: VpnEngine.vpnStatusSnapshot(),
            builder: (context, snapshot) => Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    HomeCard(
                        title: "${snapshot.data?.byteIn ?? 'NA'}",
                        subtitle: "Downlaod",
                        icon: CircleAvatar(
                          backgroundColor: Colors.green,
                          radius: 30,
                          child: Icon(
                            Icons.arrow_downward,
                            size: 30,
                            color: Colors.white,
                          ),
                        )),
                    HomeCard(
                        title: "${snapshot.data?.byteOut ?? 'NA'}",
                        subtitle: "Upload",
                        icon: CircleAvatar(
                          radius: 30,
                          backgroundColor: Colors.blue,
                          child: Icon(
                            Icons.arrow_upward,
                            size: 30,
                            color: Colors.white,
                          ),
                        )),
                  ],
                )),
      ]),
    );
  }

  Widget _vpnButton(BuildContext context) => Column(
        children: [
          Semantics(
            button: true,
            child: InkWell(
              borderRadius: BorderRadius.circular(100),
              onTap: () {
                print('he');
                _controller.connectVPN();
              },
              child: Container(
                padding: EdgeInsets.all(16),
                decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: _controller.getButtonColor.withOpacity(0.1)),
                child: Container(
                  padding: EdgeInsets.all(16),
                  decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: _controller.getButtonColor.withOpacity(0.3)),
                  child: Container(
                    decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: _controller.getButtonColor),
                    width: mq.height * 0.14,
                    height: mq.height * 0.14,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.power_settings_new_rounded,
                          size: 28,
                          color: Colors.white,
                        ),
                        SizedBox(height: 5),
                        Text(
                          _controller.getButtonText,
                          style: TextStyle(
                              fontSize: 15,
                              color: Colors.white,
                              fontWeight: FontWeight.w600),
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
          Container(
            margin: EdgeInsets.only(
                top: mq.height * 0.02, bottom: mq.height * 0.01),
            padding: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
            // decoration: BoxDecoration(
            //     color: Colors.blue, borderRadius: BorderRadius.circular(20)),
            child: Text(
              _controller.vpnState.value == VpnEngine.vpnDisconnected
                  ? "Not Connected"
                  : _controller.vpnState.replaceAll('_', ' ').toUpperCase(),
              style: TextStyle(
                  color: Theme.of(context).blackTheme,
                  fontWeight: FontWeight.w600,
                  fontSize: 16),
            ),
          ),
          Obx(() => CountDownTimer(
              startTimer:
                  _controller.vpnState.value == VpnEngine.vpnConnected)),
        ],
      );
}

Widget _changelocation(BuildContext context) => SafeArea(
      child: Semantics(
        button: true,
        child: InkWell(
          onTap: () => Get.to(() => LocationScreen()),
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: mq.height * 0.04),
            color: Theme.of(context).bottomNav,
            height: 60,
            child: Row(
              children: [
                Icon(
                  CupertinoIcons.globe,
                  size: 28,
                  color: Colors.white,
                ),
                SizedBox(width: 10),
                Text(
                  'Change Location',
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.w500),
                ),
                Spacer(),
                CircleAvatar(
                  backgroundColor: Colors.white,
                  child: Icon(
                    Icons.keyboard_arrow_right_outlined,
                    size: 28,
                    color: Colors.blue,
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );

// Center(
//           child: TextButton(
//             style: TextButton.styleFrom(
//               shape: StadiumBorder(),
//               backgroundColor: Theme.of(context).primaryColor,
//             ),
//             child: Text(
//               _controller.vpnState.value == VpnEngine.vpnDisconnected
//                   ? 'Connect VPN'
//                   : _controller.vpnState.value.replaceAll("_", " ").toUpperCase(),
//               style: TextStyle(color: Colors.white),
//             ),
//             onPressed: _connectClick,
//           ),
//         ),
//         StreamBuilder<VpnStatus?>(
//           initialData: VpnStatus(),
//           stream: VpnEngine.vpnStatusSnapshot(),
//           builder: (context, snapshot) => Text(
//               "${snapshot.data?.byteIn ?? ""}, ${snapshot.data?.byteOut ?? ""}",
//               textAlign: TextAlign.center),
//         ),

//         //sample vpn list
//         Column(
//             children: _listVpn
//                 .map(
//                   (e) => ListTile(
//                     title: Text(e.country),
//                     leading: SizedBox(
//                       height: 20,
//                       width: 20,
//                       child: Center(
//                           child: _selectedVpn == e
//                               ? CircleAvatar(backgroundColor: Colors.green)
//                               : CircleAvatar(backgroundColor: Colors.grey)),
//                     ),
//                     onTap: () {
//                       log("${e.country} is selected");
//                       setState(() => _selectedVpn = e);
//                     },
//                   ),
//                 )
//                 .toList())