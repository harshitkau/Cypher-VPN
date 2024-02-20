import 'dart:convert';
import 'dart:math';

import 'package:csv/csv.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:http/http.dart';
import 'package:vpn_basic_project/helpers/my_dialogs.dart';
import 'package:vpn_basic_project/helpers/pref.dart';
import 'package:vpn_basic_project/models/ip_details.dart';
import 'package:vpn_basic_project/models/vpn.dart';

class APIs {
  static Future<List<Vpn>> getVPN() async {
    final List<Vpn> vpnList = [];

    try {
      final res = await get(Uri.parse('https://www.vpngate.net/api/iphone/'));

      final csvString = res.body.split('#')[1].replaceAll('*', '');
      List<List<dynamic>> list = const CsvToListConverter().convert(csvString);

      final header = list[0];

      for (int i = 1; i < list.length - 1; ++i) {
        Map<String, dynamic> tempJson = {};
        for (int j = 0; j < header.length; ++j) {
          tempJson.addAll({header[j].toString(): list[i][j]});
        }
        vpnList.add(Vpn.fromJson(tempJson));
      }

      print(vpnList.first.hostname);
      // for (int i = 0; i < vpnList.length; i++) {
      //   print(vpnList[i].ip);
      // }
    } on Exception catch (e) {
      // TODO
      MyDialog.error(msg: "No Vpn found Please Try Again");
      print("Get vpn list failed\n error : $e");
    }
    vpnList.shuffle();
    if (vpnList.isNotEmpty) {
      Pref.vpnList = vpnList;
    }
    return vpnList;
  }

  static Future<void> GetIPDetails({required Rx<IpDetails> ipData}) async {
    try {
      final res = await get(Uri.parse('http://ip-api.com/json/'));
      final data = jsonDecode(res.body);
      print(data.toString());
      ipData.value = IpDetails.fromJson(data);
    } on Exception catch (e) {
      // TODO
      MyDialog.error(msg: "No Internet Connection found");
      print("Get IPDetails failed\n error : $e");
    }
  }
}
