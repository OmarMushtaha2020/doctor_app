import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:doctor_app/app/modules/home/controllers/login_controller.dart';
import 'package:doctor_app/common_widget/custom_animation.dart';
import 'package:doctor_app/common_widget/custom_buttom.dart';
import 'package:doctor_app/common_widget/custom_size_box.dart';
import 'package:doctor_app/common_widget/custom_text.dart';
import 'package:doctor_app/common_widget/custom_text_buttom.dart';
import 'package:doctor_app/common_widget/custom_text_form.dart';

import '../controllers/patients_controller.dart';

class PatientsView extends GetView<PatientsController> {
   PatientsView({Key? key}) : super(key: key);
  var email = TextEditingController();
  LoginController loginController=LoginController();
  var password = TextEditingController();
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
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CustomAnimation(
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        // CustomText(Colors.black, 30, FontWeight.w600, "The".tr),
                        CustomText(Colors.blue, 30, FontWeight.w600, "Patients".tr),

                      ],
                    ),0
                ),

                CustomSizeBox(50),
                CustomAnimation(
                  CustomTextForm(
                      email, "Enter email address".tr,TextInputType.emailAddress,    validator: (email){
                    if(email!.isEmpty){
                      return "email mustn't be empty".tr;

                    }
                  }),500,
                ),
                CustomSizeBox(
                  25,
                ),
                CustomAnimation( CustomTextForm(password, "Master password".tr,TextInputType.visiblePassword,    validator: (password){
                  if(password!.isEmpty){
                    return "password mustn't be empty".tr;

                  }
                }),1000),
                CustomSizeBox(
                  15,
                ),
                CustomAnimation(

                    Padding(
                      padding: const EdgeInsets.only(left: 5),
                      child: CustomText(Colors.black, 12, FontWeight.w600, "Forget Password?".tr,onTap: (){
                        loginController.moveBetweenPages('ForgotPasswordPatients');
                      },),
                    ),1500
                ),
                CustomSizeBox(
                  50,
                ),
                CustomAnimation(
                  CustomButtom(() {
                    if(formKey.currentState!.validate()){
                      controller.login(email.text, password.text);

                    }
                  }, Colors.blue, 50, double.infinity, 10,
                      Colors.white, "Log In".tr, 15),2000,
                ),
                CustomSizeBox(20),
                CustomAnimation(
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        CustomText(Colors.black, 12, FontWeight.w600,
                            "Not Using LastPass Yet?".tr),
                        CustomTextButtom(
                              () {
                            loginController.moveBetweenPages('Register_PATIENTS');

                          },
                          "Create an account".tr,
                          Colors.blue,
                          12,
                          FontWeight.w600,
                        ),
                      ],
                    ),2500
                ),
              ],
            ),
          ),
        ));
  }
}
