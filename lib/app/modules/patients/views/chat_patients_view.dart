import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

import 'package:get/get.dart';
import 'package:doctor_app/app/modules/home/controllers/login_controller.dart';
import 'package:doctor_app/app/modules/home/views/profile_view.dart';
import 'package:doctor_app/app/modules/patients/controllers/group_chat_patients_controller.dart';
import 'package:doctor_app/app/modules/patients/controllers/layout_patients_app_controller.dart';
import 'package:doctor_app/common_widget/custom_size_box.dart';
import 'package:doctor_app/common_widget/custom_text.dart';

class ChatPatientsView extends GetView<LayoutPatientsAppController> {
   ChatPatientsView({Key? key}) : super(key: key);
   LoginController loginController=LoginController();

   @override
  Widget build(BuildContext context) {
     return GetBuilder<LayoutPatientsAppController>(
      init: LayoutPatientsAppController(),
      builder: (controller){
        return  Scaffold(

            body:  controller.doctors.length==0? Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SpinKitFadingCube(
                  color: Colors.blue,

                  size: 50.0,
                ),
                CustomSizeBox(30),
                CustomText(Colors.black, 15, FontWeight.w600, "There is no doctors")
              ],
            ):Padding(
              padding: const EdgeInsets.only(top:10 ,bottom: 10),
              child: ListView.separated(padding: EdgeInsets.zero,physics: const BouncingScrollPhysics(),itemBuilder: (context,index)=>Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: GestureDetector(
                  onTap: (){
                    GroupChatPatientsController groupChatPatientsController =GroupChatPatientsController();
                    groupChatPatientsController.getMessages(receiverId:  controller.doctors[index].token);
                    loginController.moveBetweenPages('GroupChatPatientsView',arguments:{
                      "token":controller.doctors[index].token,
                      "cover":controller.doctors[index].cover,
                      "name":controller.doctors[index].name,
                    } );
                  },
                  child: Row(
                    children:  [
                      Stack(
                        clipBehavior: Clip.none,
                        alignment: AlignmentDirectional.bottomEnd,
                        children: [
                          customCircleAvatar(28,color:Colors.white,
                              image:"${controller.doctors[index].cover}",
                            onTap: (){
                              GroupChatPatientsController groupChatPatientsController =GroupChatPatientsController();
                              groupChatPatientsController.getMessages(receiverId:  controller.doctors[index].token);

                            }
                          ),
                          Stack(
                            alignment: AlignmentDirectional.center,
                            children: [
                              customCircleAvatar(10,color:Colors.white),
                              customCircleAvatar(7,color:Colors.blue),

                            ],
                          )

                        ],
                      ),
                      CustomSizeBox(0,width: 10,),
                      Column(crossAxisAlignment: CrossAxisAlignment.start,children: [
                        CustomText(Colors.black, 17, FontWeight.w600, "${controller.doctors[index].name}"),
                        CustomText(Colors.grey, 14, FontWeight.w400, "Pls take a look at the images."),

                      ],),
                      const Spacer(),
                      CustomText(const Color(0xff333333), 14, FontWeight.w400, "06:12")
                    ],
                  ),
                )
                ,
              ), separatorBuilder: (context,index)=>CustomSizeBox(20), itemCount: controller.doctors.length),
            )
        );
      },
    );
  }
}
