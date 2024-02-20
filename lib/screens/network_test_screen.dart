import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vpn_basic_project/apis/apis.dart';
import 'package:vpn_basic_project/main.dart';
import 'package:vpn_basic_project/models/ip_details.dart';
import 'package:vpn_basic_project/models/network_data.dart';
import 'package:vpn_basic_project/widgets/network_card.dart';

class NetworkTestScreen extends StatelessWidget {
  const NetworkTestScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final ipData = IpDetails.fromJson({}).obs;
    APIs.GetIPDetails(ipData: ipData);

    return Scaffold(
      appBar: AppBar(
        leading: InkWell(
          onTap: () => Get.back(),
          child: Icon(
            Icons.arrow_back,
            color: Colors.white,
          ),
        ),
        title: Text("Network Test Screen",
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.w600)),
        backgroundColor: Theme.of(context).bottomNav,
      ),
      floatingActionButton: Padding(
        padding: const EdgeInsets.only(bottom: 10, right: 10),
        child: FloatingActionButton(
          onPressed: () {
            ipData.value = IpDetails.fromJson({});

            APIs.GetIPDetails(ipData: ipData);
          },
          backgroundColor: Theme.of(context).bottomNav,
          child: Icon(
            Icons.refresh,
            color: Colors.white,
          ),
        ),
      ),
      body: Obx(
        () => ListView(
          padding: EdgeInsets.only(
            left: mq.width * 0.04,
            right: mq.width * 0.04,
            top: mq.height * 0.01,
            bottom: mq.height * 0.01,
          ),
          physics: BouncingScrollPhysics(),
          children: [
            NetworkCard(
              data: NetworkData(
                title: "IP Address",
                subtitle: ipData.value.query,
                icon: Icon(
                  CupertinoIcons.location_solid,
                  color: Colors.blue,
                ),
              ),
            ),

            // isp
            NetworkCard(
              data: NetworkData(
                title: "Internet Service Provider",
                subtitle: ipData.value.isp,
                icon: Icon(
                  Icons.business,
                  color: Colors.orange,
                ),
              ),
            ),
            NetworkCard(
              data: NetworkData(
                title: "Location",
                subtitle: ipData.value.country.isEmpty
                    ? "Fetching ..."
                    : "${ipData.value.city}, ${ipData.value.regionName}, ${ipData.value.country}",
                icon: Icon(
                  CupertinoIcons.location,
                  color: Colors.pink,
                ),
              ),
            ),
            NetworkCard(
              data: NetworkData(
                title: "Pin-Code",
                subtitle: ipData.value.zip,
                icon: Icon(
                  Icons.person_pin_circle_sharp,
                  color: Colors.cyan,
                ),
              ),
            ),
            NetworkCard(
              data: NetworkData(
                title: "Time Zone",
                subtitle: ipData.value.timezone,
                icon: Icon(
                  CupertinoIcons.time,
                  color: Colors.green,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
