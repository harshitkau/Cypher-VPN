import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MyDialog {
  static success({required String msg}) {
    Get.snackbar(
      "Success",
      msg,
      backgroundColor: Colors.green.withOpacity(0.9),
      colorText: Colors.white,
    );
  }

  static error({required String msg}) {
    Get.snackbar(
      "Error",
      msg,
      colorText: Colors.white,
      backgroundColor: Colors.redAccent.withOpacity(0.5),
    );
  }

  static info({required String msg}) {
    Get.snackbar(
      "Info",
      msg,
      colorText: Colors.white,
      backgroundColor: Colors.grey.withOpacity(0.8),
    );
  }
}
