import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

import 'package:get/get.dart';
import 'package:doctor_app/app/modules/home/controllers/login_controller.dart';
import 'package:doctor_app/app/modules/patients/controllers/article_controller.dart';
import 'package:doctor_app/app/modules/patients/controllers/layout_patients_app_controller.dart';
import 'package:doctor_app/common_widget/custom_size_box.dart';
import 'package:doctor_app/common_widget/custom_text.dart';
import 'package:doctor_app/shared/styles/icon_broken.dart';

class ArticleView extends GetView<ArticleController> {
   ArticleView({Key? key}) : super(key: key);
  LoginController loginController=LoginController();
   var argument=Get.arguments;
   LayoutPatientsAppController layoutPatientsAppController=LayoutPatientsAppController();

   @override
  Widget build(BuildContext context) {
controller.getAllArticle("${argument['id']}");
    return GetBuilder<ArticleController>(
      init: ArticleController(),
      builder: (controller){
        return Scaffold(
          appBar: AppBar(
            title: Row(
              children: [
                GestureDetector(onTap: (){
// LayoutPatientsAppController layout=LayoutPatientsAppController();
// controller.changeValueOfHomePatients(true);
// controller.changeValueOfSubscriptionsPatients(true);
  loginController.moveBetweenPages('LayoutPatientsAppView');

                },child: layoutPatientsAppController.initLang==Locale("ar")?Icon(IconBroken.Arrow___Right_2,color: Colors.black,): Icon(IconBroken.Arrow___Left_2,color: Colors.black,)),
                CustomSizeBox(0,width: 20,),
                CustomSizeBox(0,width: 10,),CustomText(Colors.black, 20, FontWeight.w600, "${argument['nameCategories']}"),
              ],
            ),
          ),
          body:controller.article.length==0?Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const SpinKitFadingCube(
                color: Colors.blue,

                size: 50.0,
              ),
              CustomSizeBox(30),
              CustomText(Colors.black, 15, FontWeight.w600, "There is no article")
            ],
          ): ListView.separated(itemBuilder: (controllers,index)=>                Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Container(width: double.infinity,height: 120,decoration: BoxDecoration(

              borderRadius: BorderRadius.circular(20),
              color: const Color(0xFFfafafa),

            ),child:GestureDetector(
              onTap: (){
                LoginController loginController=LoginController();
                loginController.moveBetweenPages('ArticleDetailsPatientsView',arguments: {
                  "image":controller.article[index].image,
                  "name":controller.article[index].name,
                  "nameCategories":argument['nameCategories'],
                  "id":argument['id'],
                  "details":controller.article[index].details
                });
              },
              child: Row(
                children: [
                  Padding(
                    padding: layoutPatientsAppController.initLang==Locale("ar")?EdgeInsets.only(right: 10): EdgeInsets.only(left: 10),
                    child: Container(height: 85,width: 85,decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),color: Colors.white,
                      image:  DecorationImage(image: NetworkImage("${controller.article[index].image}"),fit: BoxFit.cover),
                    ),),
                  ),
                  CustomSizeBox(0,width: 20,),
                  CustomText(Colors.black,20,FontWeight.w600,"${controller.article[index].name}"),
                  const Spacer(),
                   Padding(
                    padding:layoutPatientsAppController.initLang==Locale("ar")? EdgeInsets.only(left: 10): EdgeInsets.only(right: 10),
                    child: layoutPatientsAppController.initLang==Locale("ar") ?Icon(IconBroken.Arrow___Left_2,color: Colors.black,):Icon(IconBroken.Arrow___Right_2,color: Colors.black,),
                  ),
                ],
              ),
            )
              ,),
          ), separatorBuilder: (controller,index)=>CustomSizeBox(20,), itemCount: controller.article.length),
        );
      },
     );

  }
}
