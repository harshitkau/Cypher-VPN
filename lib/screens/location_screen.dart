import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
// import 'package:vpn_basic_project/apis/apis.dart';
import 'package:vpn_basic_project/controllers/location_controller.dart';
import 'package:vpn_basic_project/main.dart';
import 'package:vpn_basic_project/widgets/vpn_card.dart';

class LocationScreen extends StatelessWidget {
  LocationScreen({super.key});

  final _controller = LocationController();
  @override
  Widget build(BuildContext context) {
    if (_controller.VPNlist.isEmpty) _controller.getVpnData();

    return Obx(
      () => Scaffold(
        appBar: AppBar(
          leading: InkWell(
            onTap: () => Get.back(),
            child: Icon(
              Icons.arrow_back,
              color: Colors.white,
            ),
          ),
          backgroundColor: Theme.of(context).bottomNav,
          title: Text(
            'VPN Location ${_controller.isLoading.value ? '' : '(${_controller.VPNlist.length})'}',
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.w600),
          ),
        ),
        floatingActionButton: Padding(
          padding: const EdgeInsets.only(bottom: 10, right: 10),
          child: FloatingActionButton(
            backgroundColor: Color.fromRGBO(0, 53, 85, 1),
            onPressed: () => _controller.getVpnData(),
            child: Icon(
              Icons.refresh,
              color: Colors.white,
            ),
          ),
        ),
        body: _controller.isLoading.value
            ? _loadingWidget()
            : _controller.VPNlist.isEmpty
                ? _noVpnFound()
                : _vpnData(),
      ),
    );
  }

  _vpnData() => ListView.builder(
        physics: BouncingScrollPhysics(),
        itemCount: _controller.VPNlist.length,
        padding: EdgeInsets.only(
            top: mq.height * 0.005,
            bottom: mq.height * 0.05,
            left: mq.width * 0.04,
            right: mq.width * 0.04),
        itemBuilder: (context, index) => VpnCard(
          vpn: _controller.VPNlist[index],
        ),
      );

  _loadingWidget() => SizedBox(
        width: double.infinity,
        height: double.infinity,
        child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              LottieBuilder.asset(
                'assets/lottie/loading.json',
                width: mq.width * 0.5,
              ),
              Text(
                'Loading Servers...',
                style: TextStyle(
                    color: Colors.grey,
                    fontWeight: FontWeight.bold,
                    fontSize: 18),
              )
            ]),
      );

  _noVpnFound() => Center(
        child: Text(
          "No Vpn found Try again",
          style: TextStyle(
              color: Colors.grey, fontWeight: FontWeight.bold, fontSize: 18),
        ),
      );
}
