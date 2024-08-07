import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:doctor_app/app/modules/home/controllers/forgot_password_controller.dart';
import 'package:doctor_app/app/modules/home/controllers/login_controller.dart';
import 'package:doctor_app/common_widget/custom_animation.dart';
import 'package:doctor_app/common_widget/custom_buttom.dart';
import 'package:doctor_app/common_widget/custom_size_box.dart';
import 'package:doctor_app/common_widget/custom_text.dart';
import 'package:doctor_app/common_widget/custom_text_form.dart';

class ForgotPasswordView extends GetView<ForgotPasswordController> {
  ForgotPasswordView({Key? key}) : super(key: key);
  var email = TextEditingController();
  LoginController loginController = LoginController();
var formKey=GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30),
          child: Form(
            key: formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CustomSizeBox(25),
                CustomAnimation(
                    CustomText(Colors.black, 20, FontWeight.w600,
                        "Forgot the doctor's account password?".tr),
                    0),
                CustomSizeBox(10),
                CustomAnimation(
                    CustomText(
                        Colors.grey,
                        12,
                        FontWeight.w400,
                        "No worries, you just need to type your email \naddress or username and we will send the \nverification code."
                            .tr),
                    500),
                CustomSizeBox(20),
                CustomAnimation(
                    CustomTextForm(email, "Enter email address".tr,
                        TextInputType.emailAddress,validator: (value){
                      if(value!.isEmpty){
                        return "Email mustn't be empty";
                      }
                      },),
                    1000),
                CustomSizeBox(25),
                CustomAnimation(
                    CustomButtom(() {
                      if(formKey.currentState!.validate()){
                        controller.checkIsEmailInDoctorsCollection(email.text);

                      }
                    }, Colors.blue, 50, double.infinity, 10, Colors.white,
                        "Reset My Password".tr, 15),
                    1500)
              ],
            ),
          ),
        ));
  }
}
