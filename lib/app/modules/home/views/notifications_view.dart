import 'package:doctor_app/app/modules/home/controllers/layout_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

import 'package:get/get.dart';
import 'package:doctor_app/common_widget/custom_size_box.dart';
import 'package:doctor_app/common_widget/custom_text.dart';
import 'package:doctor_app/shared/styles/icon_broken.dart';

class NotificationsView extends GetView {
  const NotificationsView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<LayoutController>(
      init:LayoutController() ,builder: (controller){
        return  Scaffold(
          body: controller.onMessageNotification.length==0?            Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const SpinKitFadingCube(
                color: Colors.blue,
                size: 50.0,
              ),
              CustomSizeBox(30),
              CustomText(Colors.black, 15, FontWeight.w600,
                  "There is No Notification Message")
            ],
          ): ListView.separated(
              padding: EdgeInsets.zero,
              itemBuilder: (context, index) => Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Container(
                  height: 100,
                  decoration: BoxDecoration(
                    color: const Color(0xFFfafafa),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Row(
                      children: [
                        Container(
                          height: 50,
                          width: 50,
                          decoration: BoxDecoration(
                            color: Colors.blue,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: const Icon(
                            IconBroken.Notification,
                            color: Colors.white,
                          ),
                        ),
                        CustomSizeBox(
                          0,
                          width: 15,
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            CustomText(Colors.black, 17, FontWeight.w600,
                                "${controller.onMessageNotification[index].name}"),
                            CustomText(Colors.grey, 14, FontWeight.w400,
                                "${controller.onMessageNotification[index].body}"),
                          ],
                        ),
                        const Spacer(),
                        const Icon(Icons.cancel_outlined)
                      ],
                    ),
                  ),
                ),
              ),
              separatorBuilder: (context, index) => CustomSizeBox(20),
              itemCount: controller.onMessageNotification.length),
        );
    },
    );
  }
}
