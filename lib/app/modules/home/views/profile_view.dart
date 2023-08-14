import 'package:cached_network_image/cached_network_image.dart';
import 'package:doctor_app/app/modules/patients/controllers/layout_patients_app_controller.dart';
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
final layout=Get.lazyPut(() => LayoutPatientsAppController());
  LayoutPatientsAppController layoutPatientsAppController=LayoutPatientsAppController();

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
                      SizedBox(
                        width: double.infinity,
                        height: 200,
                        child:  CachedNetworkImage(
                          fit: BoxFit.cover,
                          imageUrl: "${doctorAccountModel?.image}",
                          progressIndicatorBuilder: (context, url, downloadProgress) =>
                            const SizedBox(width: double.infinity,height: 200),
                          errorWidget: (context, url, error) =>  const SizedBox(width: double.infinity,height: 200),
                        ),

                      ),
                      0),
                  Positioned(
                    top: 130,
                    child: CustomAnimation(
                        Stack(
                          alignment: AlignmentDirectional.center,
                          children: [
                            Container(
                              width: 125,
                              clipBehavior: Clip.antiAliasWithSaveLayer,
                              height: 125,
                              decoration: const BoxDecoration(
                                  shape: BoxShape.circle,
                                color: Colors.white
                              ),

                            ),
                            Container(
                              width: 120,
                              clipBehavior: Clip.antiAliasWithSaveLayer,
                              height: 120,
                              decoration: const BoxDecoration(
                                  shape: BoxShape.circle
                              ),
                              child:  CachedNetworkImage(
                                fit: BoxFit.cover,
                                imageUrl: "${doctorAccountModel?.cover}",
                                progressIndicatorBuilder: (context, url, downloadProgress) =>
                                const SizedBox(width: double.infinity,height: 200),
                                errorWidget: (context, url, error) =>  const SizedBox(width: double.infinity,height: 200),
                              ),

                            ),

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
                      layoutPatientsAppController.initLang.toString().contains("ar")?
                      Row(
                        children: [
                          CustomSizeBox(
                            0,
                            width: 5,
                          ),
                          customOutlineButtom(const Icon(IconBroken.Logout), () {
                            GetStorage().remove("token").then((value) {
                              loginController.moveBetweenPages(
                                  'PageSelectionDoctorOrPatient');
                            });
                          }),

                          CustomSizeBox(
                            0,
                            width: 5,
                          ),
                          customOutlineButtom(const Icon(IconBroken.Edit), () {
                            controller.getDoctorsData();
                            loginController
                                .moveBetweenPages('UpdateProfileView');
                          }),
                          CustomSizeBox(
                            0,
                            width: 5,
                          ),

                          Expanded(
                              child: customOutlineButtom(
                                  CustomText(Colors.blue, 15, FontWeight.w400,
                                      "Add an article".tr),
                                      () {})),

                        ],
                      ):           Row(
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
                          customOutlineButtom(const Icon(IconBroken.Edit), () {
                            controller.getDoctorsData();
                            loginController
                                .moveBetweenPages('UpdateProfileView');
                          }),
                          CustomSizeBox(
                            0,
                            width: 5,
                          ),
                          customOutlineButtom(const Icon(IconBroken.Logout), () {
                            controller.changeValueOfIndex(0);
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
          backgroundImage: NetworkImage("$image"),
        ));

Widget customOutlineButtom(Widget widget, void Function() onPressed) =>
    OutlinedButton(onPressed: onPressed, child: widget);
