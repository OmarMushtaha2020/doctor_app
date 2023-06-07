import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:doctor_app/app/modules/home/controllers/layout_controller.dart';
import 'package:doctor_app/app/modules/home/controllers/login_controller.dart';
import 'package:doctor_app/common_widget/custom_animation.dart';
import 'package:doctor_app/common_widget/custom_size_box.dart';
import 'package:doctor_app/common_widget/custom_text.dart';
import 'package:doctor_app/shared/styles/icon_broken.dart';

import '../controllers/create_password_controller.dart';

class ProfileView extends GetView<LayoutController> {
  ProfileView({Key? key}) : super(key: key);
  LoginController loginController = LoginController();

  @override
  Widget build(BuildContext context) {
    return GetBuilder<LayoutController>(
      init: LayoutController(),
      builder: (Controller) {
        return Scaffold(
            body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Column(
            children: [
              Stack(
                alignment: AlignmentDirectional.bottomCenter,
                clipBehavior: Clip.none,
                children: [
                  CustomAnimation(
                      Container(
                        width: double.infinity,
                        height: 200,
                        decoration: BoxDecoration(
                          image: DecorationImage(
                              image:
                                  NetworkImage('${doctorAccountModel?.image}'),
                              fit: BoxFit.cover),
                        ),
                      ),
                      0),
                  Positioned(
                    top: 130,
                    child: CustomAnimation(
                        Stack(
                          alignment: AlignmentDirectional.center,
                          children: [
                            customCircleAvatar(62, color: Colors.white),
                            customCircleAvatar(60,
                                color: Colors.white,
                                image: "${doctorAccountModel?.cover}"),
                          ],
                        ),
                        500),
                  )
                ],
              ),
              CustomSizeBox(
                60,
              ),
              Column(
                children: [
                  CustomAnimation(
                      CustomText(Colors.black, 20, FontWeight.w600,
                          "${doctorAccountModel?.name}"),
                      1000),
                  CustomAnimation(
                      CustomText(Colors.grey, 14, FontWeight.w400,
                          "${doctorAccountModel?.bio}"),
                      1500),
                  CustomSizeBox(
                    10,
                  ),
                  CustomAnimation(
                      Row(
                        children: [
                          Expanded(
                              child: customOutlineButtom(
                                  CustomText(Colors.blue, 15, FontWeight.w400,
                                      "Add an article".tr),
                                  () {})),
                          CustomSizeBox(
                            0,
                            width: 5,
                          ),
                          customOutlineButtom(Icon(IconBroken.Edit), () {
                            controller.getDoctorsData();
                            loginController
                                .moveBetweenPages('UpdateProfileView');
                          }),
                          CustomSizeBox(
                            0,
                            width: 5,
                          ),
                          customOutlineButtom(Icon(IconBroken.Logout), () {
                            GetStorage().remove("token").then((value) {
                              loginController.moveBetweenPages(
                                  'PageSelectionDoctorOrPatient');
                            });
                          }),
                        ],
                      ),
                      2000),
                ],
              ),
            ],
          ),
        ));
      },
    );
  }
}

Widget customCircleAvatar(double raduis,
        {Color? color,
        String? image,
        Widget? widget,
        void Function()? onTap}) =>
    GestureDetector(
        onTap: onTap,
        child: CircleAvatar(
          child: widget,
          radius: raduis,
          backgroundColor: color,
          backgroundImage: NetworkImage(image ?? ""),
        ));

Widget customOutlineButtom(Widget widget, void Function() onPressed) =>
    OutlinedButton(onPressed: onPressed, child: widget);
