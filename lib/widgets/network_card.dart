import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:vpn_basic_project/main.dart';
import 'package:vpn_basic_project/models/network_data.dart';

class NetworkCard extends StatelessWidget {
  final NetworkData data;
  const NetworkCard({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    return Card(
      // color: Colors.white,
      color: Theme.of(context).networkTheme,
      margin: EdgeInsets.symmetric(vertical: mq.height * 0.01),
      elevation: 5,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      child: ListTile(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
        leading: Icon(
          data.icon.icon,
          color: data.icon.color,
          size: data.icon.size ?? 28,
        ),
        title: Text(data.title),
        subtitle: Text(data.subtitle),
      ),
    );
  }
}
