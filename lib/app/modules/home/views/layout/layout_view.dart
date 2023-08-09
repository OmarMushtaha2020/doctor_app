import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:doctor_app/app/modules/home/controllers/layout_controller.dart';
import 'package:doctor_app/common_widget/custom_text.dart';
import 'package:doctor_app/shared/styles/icon_broken.dart';

bool valueOfHome = false;

class LayoutView extends GetView<LayoutController> {
  @override
  Widget build(BuildContext context) {

    return GetBuilder<LayoutController>(
      init: LayoutController(),
      builder: (controller) {
        return Scaffold(
          appBar: AppBar(
            centerTitle: false,
            title: CustomText(Colors.black, 20, FontWeight.w600,
                controller.titleOfScreen[index]),
            actions: [],
          ),
          body: controller.screen[index],
          bottomNavigationBar: BottomNavigationBar(
            backgroundColor: Colors.white,
            type: BottomNavigationBarType.fixed,
            currentIndex: index,
            onTap: (index) {
              print(index);
              controller.changeValueOfIndex(index);
            },
            items: [
              BottomNavigationBarItem(
                icon: const Icon(IconBroken.Home),
                label: 'Home'.tr,
              ),
              BottomNavigationBarItem(
                icon: const Icon(
                  IconBroken.Message,
                ),
                label: 'Chat'.tr,
              ),
              BottomNavigationBarItem(
                icon: const Icon(
                  IconBroken.Notification,
                ),
                label: 'Notification'.tr,
              ),
              BottomNavigationBarItem(
                  icon: const Icon(IconBroken.Profile), label: "Profile".tr),
            ],
          ),
        );
      },
    );
  }
}
