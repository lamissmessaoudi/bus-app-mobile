import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:softun_bus_mobile/style/colors.dart';

getErrorSnackBar({title: String, message: String}) {
  Get.closeAllSnackbars();
  // Get.closeCurrentSnackbar();

  return Get.snackbar(
    title,
    message,
    borderRadius: 8,
    snackPosition: SnackPosition.TOP,
    isDismissible: true,
    backgroundColor: AppColors.errorColor,
    margin: const EdgeInsets.all(4),
    colorText: AppColors.white,
    duration: const Duration(milliseconds: 2500),
  );
}

getSuccessSnackBar({title: String, message: String}) {
  Get.closeAllSnackbars();
  // Get.closeCurrentSnackbar();

  return Get.snackbar(
    title,
    message,
    borderRadius: 8,
    snackPosition: SnackPosition.TOP,
    isDismissible: true,
    backgroundColor: AppColors.green,
    margin: const EdgeInsets.all(4),
    colorText: AppColors.white,
    duration: const Duration(milliseconds: 2500),
  );
}
