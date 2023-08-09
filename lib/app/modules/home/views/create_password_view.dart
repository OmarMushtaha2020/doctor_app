import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:doctor_app/app/modules/home/controllers/create_password_controller.dart';
import 'package:doctor_app/common_widget/custom_buttom.dart';
import 'package:doctor_app/common_widget/custom_size_box.dart';
import 'package:doctor_app/common_widget/custom_text.dart';
import 'package:doctor_app/common_widget/custom_text_form.dart';

import '../../../../common_widget/custom_animation.dart';

class CreatePasswordView extends GetView<CreatePasswordController> {
  CreatePasswordView({Key? key}) : super(key: key);
  var password = TextEditingController();
  var confirm_password = TextEditingController();
  var token = Get.arguments;
  var formKey=GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30),
          child: Form(
            key: formKey,
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment:
                CrossAxisAlignment.start,
                children: [
                  CustomSizeBox(25),
                  CustomAnimation(
                      CustomText(Colors.black, 20, FontWeight.w600,
                          "Create a new password for the doctor's account".tr),
                      0),
                  CustomSizeBox(10),
                  CustomAnimation(
                      CustomText(Colors.grey, 12, FontWeight.w400,
                          "Create your new password to login".tr),
                      500),
                  CustomSizeBox(20),
                  CustomAnimation(
                      CustomTextForm(
                          password, "PASSWORD".tr, TextInputType.visiblePassword,validator: (value){
                            if(value!.isEmpty){
                              return "Password mustn't be empty";
                            }
                            return null;
                      },),
                      1000),
                  CustomSizeBox(20),
                  CustomAnimation(
                      CustomTextForm(confirm_password, "CONFIRM PASSWORD".tr,
                          TextInputType.visiblePassword,validator: (value){
                            if(value!.isEmpty){
                              return "Confirm Password mustn't be empty";
                            }
                            return null;
                          }),
                      1500),
                  CustomSizeBox(25),
                  CustomAnimation(
                      CustomButtom(() {
                        if(formKey.currentState!.validate()){
                          controller.upatePasswordOfAccountDoctors(
                              token, password.text, confirm_password.text);
                        }

                      }, Colors.blue, 50, double.infinity, 10, Colors.white,
                          "Save".tr, 15),
                      2000)
                ],
              ),
            ),
          ),
        ));
  }
}
