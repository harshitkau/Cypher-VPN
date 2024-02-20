import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vpn_basic_project/controllers/home_controller.dart';
import 'package:vpn_basic_project/helpers/my_dialogs.dart';
import 'package:vpn_basic_project/helpers/pref.dart';
import 'package:vpn_basic_project/main.dart';
import 'package:vpn_basic_project/models/vpn.dart';
import 'package:vpn_basic_project/services/vpn_engine.dart';

class VpnCard extends StatelessWidget {
  final Vpn vpn;
  const VpnCard({super.key, required this.vpn});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<HomeController>();
    return Card(
      color: Theme.of(context).networkTheme,
      margin: EdgeInsets.symmetric(vertical: mq.height * 0.008),
      elevation: 5,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      child: InkWell(
        onTap: () {
          controller.vpn.value = vpn;
          Pref.vpn = vpn;
          Get.back();
          MyDialog.success(msg: 'Connecting VPN Location...');

          if (controller.vpnState.value == VpnEngine.vpnConnected) {
            VpnEngine.stopVpn();
            Future.delayed(Duration(seconds: 2), () => controller.connectVPN());
          } else {
            controller.connectVPN();
          }
        },
        borderRadius: BorderRadius.circular(15),
        child: ListTile(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
          leading: Container(
            padding: EdgeInsets.all(0.5),
            decoration: BoxDecoration(
                border: Border.all(color: Colors.black12),
                borderRadius: BorderRadius.circular(5)),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(5),
              child: Image.asset(
                'assets/flags/${vpn.countryShort.toLowerCase()}.png',
                height: 40,
                width: mq.width * 0.15,
                fit: BoxFit.cover,
              ),
            ),
          ),
          title: Text(vpn.countryLong),
          subtitle: Row(
            children: [
              Icon(
                Icons.speed_rounded,
                color: Colors.blue,
                size: 20,
              ),
              SizedBox(width: 4),
              Text(
                _fromByte(vpn.speed, 1),
                style: TextStyle(fontSize: 13),
              ),
            ],
          ),
          trailing: Row(mainAxisSize: MainAxisSize.min, children: [
            Text(vpn.numVpnSessions.toString(),
                style: TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w500,
                    color: Theme.of(context).lightText)),
            SizedBox(width: 4),
            Icon(
              CupertinoIcons.person_3,
              color: Colors.blue,
              size: 20,
            ),
          ]),
        ),
      ),
    );
  }

  String _fromByte(int byte, int decimals) {
    if (byte == 0) return "0 B";
    const suffix = ['Bps', 'Kbps', 'Mbps', 'Gbps', 'Tbps'];
    var i = (log(byte) / log(1024)).floor();
    return '${(byte / pow(1024, i)).toStringAsFixed(decimals)} ${suffix[i]}';
  }
}
