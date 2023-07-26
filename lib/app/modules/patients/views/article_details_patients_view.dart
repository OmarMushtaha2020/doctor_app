import 'package:doctor_app/app/modules/patients/controllers/layout_patients_app_controller.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:doctor_app/app/modules/home/controllers/login_controller.dart';
import 'package:doctor_app/common_widget/custom_animation.dart';
import 'package:doctor_app/common_widget/custom_size_box.dart';
import 'package:doctor_app/common_widget/custom_text.dart';
import 'package:doctor_app/shared/styles/icon_broken.dart';

class ArticleDetailsPatientsView extends GetView<LayoutPatientsAppController> {
  ArticleDetailsPatientsView({Key? key}) : super(key: key);
   LoginController login=LoginController();
LayoutPatientsAppController layoutPatientsAppController=LayoutPatientsAppController();
   var argument=Get.arguments;
  @override
  Widget build(BuildContext context) {
    return GetBuilder<LayoutPatientsAppController>(
      init: LayoutPatientsAppController(),
      builder: (controller){
        return  Scaffold(
            body: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Stack(
                    children: [

                      Image(image:NetworkImage("${argument['image']}"),height: 400,width: double.infinity,fit: BoxFit.cover,),
                      layoutPatientsAppController.initLang==Locale("ar")?
                      Padding(
                        padding: const EdgeInsets.only(right: 20,top: 60),
                        child: GestureDetector(
                          onTap: (){

                            login.moveBetweenPages('ArticleView',arguments: {
                              'id':argument['id'],
                              'nameCategories':argument['nameCategories'],
                            });

                          },
                          child: Container(child: Icon(IconBroken.Arrow___Right_2),width: 50,height: 50,decoration: BoxDecoration(
                            color: Colors.white,

                            borderRadius: BorderRadius.circular(10),
                          ),),
                        ),
                      ):  Padding(
                        padding: const EdgeInsets.only(left: 20,top: 60),
                        child: GestureDetector(
                          onTap: (){

                            login.moveBetweenPages('ArticleView',arguments: {
                              'id':argument['id'],
                              'nameCategories':argument['nameCategories'],
                            });

                          },
                          child: Container(child: Icon(IconBroken.Arrow___Left_2),width: 50,height: 50,decoration: BoxDecoration(
                            color: Colors.white,

                            borderRadius: BorderRadius.circular(10),
                          ),),
                        ),
                      ),

                    ],
                  ),
                  CustomSizeBox(20),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 30),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            CustomAnimation( CustomText(Colors.black, 20, FontWeight.w600, "Name :".tr),0),
                            CustomSizeBox(0,width: 10,),

                            CustomAnimation( CustomText(Colors.black, 20, FontWeight.w600, "${argument['name']}"),0),

                          ],
                        ),

                        CustomSizeBox(20),

                        CustomAnimation( CustomText(Colors.black, 20, FontWeight.w600, "Details :".tr),0),
                        CustomSizeBox(10),

                        CustomAnimation( CustomText(Colors.black, 20, FontWeight.w600, "${argument['details']}"),0),

                      ],
                    ),
                  ),

                ],
              ),
            )
        );
      },
    );
  }
}
