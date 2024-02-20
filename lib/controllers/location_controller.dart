import 'package:get/get.dart';
import 'package:vpn_basic_project/apis/apis.dart';
import 'package:vpn_basic_project/helpers/pref.dart';
import 'package:vpn_basic_project/models/vpn.dart';

class LocationController extends GetxController {
  List<Vpn> VPNlist = Pref.vpnList;
  final RxBool isLoading = false.obs;

  Future<void> getVpnData() async {
    isLoading.value = true;
    VPNlist.clear();
    VPNlist = await APIs.getVPN();
    isLoading.value = false;
  }
}
