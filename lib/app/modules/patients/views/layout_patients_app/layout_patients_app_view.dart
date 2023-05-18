import 'package:doctor_app/app/modules/home/controllers/layout_controller.dart';
import 'package:doctor_app/common_widget/custom_size_box.dart';
import 'package:doctor_app/shared/locale/locale_controller.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:doctor_app/app/modules/home/controllers/login_controller.dart';
import 'package:doctor_app/app/modules/patients/controllers/layout_patients_app_controller.dart';
import 'package:doctor_app/common_widget/custom_text.dart';
import 'package:doctor_app/shared/styles/icon_broken.dart';

class LayoutPatientsAppView extends GetView<LayoutPatientsAppController> {
   LayoutPatientsAppView({Key? key}) : super(key: key);
  LoginController loginController=LoginController();


  @override
  Widget build(BuildContext context) {
    controller.getAllCategories();
    controller.getAllAccountDoctors();
    controller.getAllSubsriptions();


    return GetBuilder<LayoutPatientsAppController>(
      init: LayoutPatientsAppController(),
      builder: (controller){
        return  Scaffold(
          appBar:               AppBar(actions: [
            Padding(
              padding: const EdgeInsets.only(right: 10),
              child: IconButton(onPressed: (){
                loginController.moveBetweenPages('SearchView');
              }, icon: const Icon(IconBroken.Search,color: Colors.black,)),
            ),
            Padding(
              padding: const EdgeInsets.only(right: 20),
              child: GestureDetector(onTap: (){
                Get.defaultDialog(    title: '',content:Container(height: 120,child: Column(
                  children: [
                    GestureDetector(
                      onTap:(){
                        controller.changeLang('en');
                        loginController.moveBetweenPages('LayoutPatientsAppView');
                      },
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 30),
                        child:   Container(child:  const Center(child: Text("English",style: TextStyle(color: Colors.white,fontSize: 20))),height: 50,width: double.infinity,decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: Colors.blue,
                        ),),
                      ),
                    ),
                    CustomSizeBox(10),
                    GestureDetector(
                      onTap: (){
                        loginController.moveBetweenPages('LayoutPatientsAppView');

                        controller.changeLang('ar');

                      },
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 30),
                        child:   Container(child: const Center(child: Text("Arbic",style: TextStyle(color: Colors.white,fontSize: 20),)),height: 50,width: double.infinity,decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: Colors.blue,

                        ),),
                      ),
                    ),

                  ],
                ),));
              },child: const Icon(Icons.language_sharp,color: Colors.black,)),
            ),

          ],titleSpacing: 20,centerTitle: false,title: CustomText(Colors.black,20,FontWeight.w600,controller.titleOfPatientsScreen[indexPatients]),),
      body: controller.screenPatients[indexPatients] ,

          bottomNavigationBar: BottomNavigationBar(
            type: BottomNavigationBarType.fixed,

            currentIndex:indexPatients ,
            onTap: (index){
              controller.changeValueOfIndex(index);
            },
            items:  [
              BottomNavigationBarItem(

                icon: const Icon(IconBroken.Home),
                label: 'Home'.tr,
              ),
              BottomNavigationBarItem(
                icon:const Icon(IconBroken.Message,),
                label: 'Chat'.tr,
              ),
              BottomNavigationBarItem(
                icon:const Icon(IconBroken.Category),
                label: 'Subscriptions'.tr,
              ),
              
              BottomNavigationBarItem(icon: const Icon(IconBroken.Profile),label: "Profile".tr),
            ],
          ),
        );
      },

    );
  }
}
