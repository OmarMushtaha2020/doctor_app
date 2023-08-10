import 'package:cached_network_image/cached_network_image.dart';
import 'package:doctor_app/app/modules/patients/controllers/layout_patients_app_controller.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:doctor_app/app/modules/home/controllers/create_password_controller.dart';
import 'package:doctor_app/app/modules/home/controllers/layout_controller.dart';
import 'package:doctor_app/app/modules/home/controllers/login_controller.dart';
import 'package:doctor_app/app/modules/home/controllers/update_profile_controller.dart';
import 'package:doctor_app/common_widget/custom_animation.dart';
import 'package:doctor_app/common_widget/custom_size_box.dart';
import 'package:doctor_app/common_widget/custom_text.dart';
import 'package:doctor_app/common_widget/custom_text_buttom.dart';
import 'package:doctor_app/common_widget/custom_text_form.dart';
import 'package:doctor_app/shared/styles/icon_broken.dart';

import 'profile_view.dart';

class UpdateProfileView extends GetView<UpdateProfileController> {
  UpdateProfileView({Key? key}) : super(key: key);
  var name = TextEditingController();
  var bio = TextEditingController();
  var phone = TextEditingController();
  LayoutPatientsAppController layoutPatientsAppController =
      LayoutPatientsAppController();
  LoginController loginController = LoginController();

  @override
  Widget build(BuildContext context) {
    name.text = doctorAccountModel?.name;
    bio.text = doctorAccountModel?.bio;
    phone.text = doctorAccountModel?.phone;
    var formKey = GlobalKey<FormState>();

    return GetBuilder<UpdateProfileController>(
      init: UpdateProfileController(),
      builder: (controller) {
        return Scaffold(
            appBar: AppBar(
              title: Row(
                children: [
                  GestureDetector(
                      onTap: () {
                        final layoutPatientsAppController =
                            Get.lazyPut(() => LayoutController());

                        loginController.moveBetweenPages('layout');
                      },
                      child: layoutPatientsAppController.initLang
                              .toString()
                              .contains("ar")
                          ? const Icon(
                              IconBroken.Arrow___Right_2,
                              color: Colors.black,
                            )
                          : const Icon(
                              IconBroken.Arrow___Left_2,
                              color: Colors.black,
                            )),
                  const SizedBox(
                    width: 20,
                  ),
                  CustomText(
                      Colors.black, 18, FontWeight.w600, "Edit Profile".tr),
                ],
              ),
              actions: [
                Padding(
                  padding: const EdgeInsets.only(right: 5),
                  child: CustomTextButtom(() {
                    if (formKey.currentState!.validate()) {
                      if (controller.valueOfImage != null) {
                        controller.updateDoctorsData(
                            name: name.text,
                            phone: phone.text,
                            bio: bio.text,
                            image: controller.valueOfImage);
                      }
                      if (controller.valueOfCover != null) {
                        controller.updateDoctorsData(
                            name: name.text,
                            phone: phone.text,
                            bio: bio.text,
                            cover: controller.valueOfCover);
                      }
                      if (controller.valueOfCover == null &&
                          controller.valueOfImage == null) {
                        controller.updateDoctorsData(
                            name: name.text, phone: phone.text, bio: bio.text);
                      }
                      if (controller.valueOfCover != null &&
                          controller.valueOfImage != null) {
                        controller.updateDoctorsData(
                            name: name.text,
                            phone: phone.text,
                            bio: bio.text,
                            cover: controller.valueOfCover,
                            image: controller.valueOfImage);
                      }
                    }
                  }, "UPDATE".tr, Colors.blue, 15, FontWeight.w400),
                )
              ],
              centerTitle: true,
            ),
            body: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
              child: Form(
                key: formKey,
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      Stack(
                        alignment: AlignmentDirectional.bottomCenter,
                        clipBehavior: Clip.none,
                        children: [
                          CustomAnimation(
                              Stack(
                                alignment: AlignmentDirectional.topEnd,
                                children: [
                                  Container(
                                    width: double.infinity,
                                    height: 200,

                                    child: controller.coverImage == null
                                        ? CachedNetworkImage(
                                      fit: BoxFit.cover,
                                      imageUrl: "${doctorAccountModel?.cover}",
                                      progressIndicatorBuilder: (context, url, downloadProgress) =>
                                      const SizedBox(width: double.infinity,height: 200),
                                      errorWidget: (context, url, error) =>  const SizedBox(width: double.infinity,height: 200),
                                    ):Image.file(controller
                                        .coverImage!,fit: BoxFit.cover,),
                                  ),
                                  // Padding(
                                  //   padding: const EdgeInsets.all(8.0),
                                  //   child: customCircleAvatar(18,
                                  //       color: Colors.blue,
                                  //       widget: const Icon(IconBroken.Camera),
                                  //       onTap: () {
                                  //     controller.getCoverImage(
                                  //         name.text, phone.text, bio.text);
                                  //   }),
                                  // ),
                                ],
                              ),
                              0),
                          Positioned(
                            top: 130,
                            child: CustomAnimation(
                                Stack(
                                  alignment: AlignmentDirectional.bottomEnd,
                                  children: [
                                    GestureDetector(
                                      onTap: () {
                                        controller.getProfileImage(
                                            name.text, phone.text, bio.text);
                                      },
                                      child: Stack(
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
                                            child: controller
                                                .profileImage ==
                                                null? CachedNetworkImage(
                                              fit: BoxFit.cover,
                                              imageUrl: "${doctorAccountModel?.image}",
                                              progressIndicatorBuilder: (context, url, downloadProgress) =>
                                              const SizedBox(width: double.infinity,height: 200),
                                              errorWidget: (context, url, error) =>  const SizedBox(width: double.infinity,height: 200),
                                            ):Image.file(controller
                                                .profileImage!,fit: BoxFit.cover,),

                                          ),

                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                                500),
                          )
                        ],
                      ),
                      CustomSizeBox(
                        80,
                      ),
                      Column(
                        children: [
                          CustomAnimation(
                            CustomTextForm(
                                name, "Enter your name".tr, TextInputType.name,
                                validator: (name) {
                              if (name!.isEmpty) {
                                return "name mustn't be empty".tr;
                              }
                            }),
                            1000,
                          ),
                          CustomSizeBox(10),
                          CustomAnimation(
                            CustomTextForm(
                                bio, "Enter your bio".tr, TextInputType.text,
                                validator: (bio) {
                              if (bio!.isEmpty) {
                                return "bio mustn't be empty".tr;
                              }
                            }),
                            1500,
                          ),
                          CustomSizeBox(10),
                          CustomAnimation(
                            CustomTextForm(phone, "Enter your phoneNumber".tr,
                                TextInputType.phone, validator: (phone) {
                              if (phone!.isEmpty) {
                                return "phoneNumber mustn't be empty".tr;
                              }
                            }),
                            2000,
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ));
      },
    );
  }
}
