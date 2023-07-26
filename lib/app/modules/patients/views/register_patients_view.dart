import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:doctor_app/app/modules/home/controllers/login_controller.dart';
import 'package:doctor_app/app/modules/patients/controllers/register_patients_controller.dart';
import 'package:doctor_app/common_widget/custom_animation.dart';
import 'package:doctor_app/common_widget/custom_buttom.dart';
import 'package:doctor_app/common_widget/custom_size_box.dart';
import 'package:doctor_app/common_widget/custom_text.dart';
import 'package:doctor_app/common_widget/custom_text_buttom.dart';
import 'package:doctor_app/common_widget/custom_text_form.dart';

class RegisterPatientsView extends GetView<RegisterPatientsController> {
   RegisterPatientsView({Key? key}) : super(key: key);
  var email = TextEditingController();
  var password = TextEditingController();
  var name = TextEditingController();
  var phone = TextEditingController();
   var formKey=GlobalKey<FormState>();

   LoginController loginController=Get.put(LoginController());
  @override
  Widget build(BuildContext context) {
    return GetBuilder<RegisterPatientsController>(
      init: RegisterPatientsController(),
      builder: (controller){
        return Scaffold(
          appBar: AppBar(
          ),
          body: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30),
            child: Form(
              key: formKey,
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CustomAnimation( CustomText(Colors.black, 30, FontWeight.w600, "Let's create a patient account".tr),0),
                    CustomSizeBox(
                      50,
                    ),
                    CustomAnimation(
                        CustomTextForm(
                            name, "Enter your name".tr,TextInputType.name,validator: (name){
                          if(name!.isEmpty){
                            return "name mustn't be empty".tr;

                          }
                        }),
                        500),
                    CustomSizeBox(
                      25,
                    ),
                    CustomAnimation(
                        CustomTextForm(
                            email, "Enter email address".tr,TextInputType.emailAddress,validator: (email){
                          if(email!.isEmpty){
                            return "email mustn't be empty".tr;

                          }
                        }),
                        1000),
                    CustomSizeBox(
                      25,
                    ),
                    CustomAnimation(
                        CustomTextForm(
                            phone, "Enter your phoneNumber".tr,TextInputType.phone,validator: (phoneNumber){
                          if(phoneNumber!.isEmpty){
                            return "phoneNumber mustn't be empty".tr;

                          }
                        }),
                        1500 ),
                    CustomSizeBox(
                      25,
                    ),
                    CustomAnimation(
                        CustomTextForm(
                            password, "Enter your password".tr,TextInputType.visiblePassword,validator: (password){
                          if(password!.isEmpty){
                            return "password mustn't be empty".tr;

                          }
                        }),2000
                    ),
                    CustomSizeBox(
                      50,
                    ),
                    CustomAnimation(
                      controller.registerValue==false?
                      CustomButtom(() {
                          if(formKey.currentState!.validate()){
                            controller.register(email.text, password.text, name.text, phone.text);

                          }
                        }, Colors.blue, 50, double.infinity, 10,
                            Colors.white, "Continue".tr, 15):Center(child: const CircularProgressIndicator()),2500
                    ),
                    CustomSizeBox(20),
                    CustomAnimation(
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            CustomText(Colors.black, 12, FontWeight.w600,
                                "Already have an account?".tr),
                            CustomTextButtom(
                                  () {
                                loginController.moveBetweenPages('patients');
                              },
                              "Log In".tr,
                              Colors.blue,
                              12,
                              FontWeight.w600,
                            ),
                          ],
                        ),3000
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
