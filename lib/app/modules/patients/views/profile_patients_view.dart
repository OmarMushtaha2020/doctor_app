import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:doctor_app/app/modules/home/controllers/login_controller.dart';
import 'package:doctor_app/app/modules/home/controllers/register_controller.dart';
import 'package:doctor_app/app/modules/home/views/profile_view.dart';
import 'package:doctor_app/app/modules/patients/controllers/layout_patients_app_controller.dart';
import 'package:doctor_app/common_widget/custom_animation.dart';
import 'package:doctor_app/common_widget/custom_size_box.dart';
import 'package:doctor_app/common_widget/custom_text.dart';
import 'package:doctor_app/shared/styles/icon_broken.dart';

class ProfilePatientsView extends GetView <LayoutPatientsAppController>{
   ProfilePatientsView({Key? key}) : super(key: key);
   LoginController loginController=LoginController();
  @override
  Widget build(BuildContext context) {
    return  GetBuilder<LayoutPatientsAppController>(
      init: LayoutPatientsAppController(),
      builder: (controller){
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
                          Container(
                            width:double.infinity,
                            height: 200,
                            decoration:   BoxDecoration(

                              image: DecorationImage(image: NetworkImage('${patientsAccountModel?.cover}'),fit: BoxFit.cover),
                            ),
                          ),0
                      ),
                      Positioned(
                        top: 130,
                        child: CustomAnimation(
                            Stack(
                              alignment: AlignmentDirectional.center,
                              children: [                    customCircleAvatar(62,color:Colors.white),

                                customCircleAvatar(60,color:Colors.white,image:"${patientsAccountModel?.image}"),

                              ],
                            ),500
                        ),
                      )
                    ],
                  ),
                  CustomSizeBox( 60,),

                  Column(
                    children: [
                      CustomAnimation( CustomText(Colors.black, 20, FontWeight.w600, "${patientsAccountModel?.name}"),1000),
                      CustomAnimation( CustomText(Colors.grey, 14, FontWeight.w400, "${patientsAccountModel?.bio}"),1500),
                      CustomSizeBox( 10,),

                      CustomAnimation(
                          Row(children: [

                            
                            Expanded(
                              child: customOutlineButtom(const Icon(IconBroken.Edit),(){
                                controller.getPatientsData();
                                loginController.moveBetweenPages('UpdateProfilePatientsView');

                              }),
                            ),
                            CustomSizeBox(0,width: 5,),
                            Expanded(
                              child: customOutlineButtom(const Icon(IconBroken.Logout),(){
                                GetStorage().remove("tokenOfPatients").then((value){
                                  loginController.moveBetweenPages('PageSelectionDoctorOrPatient');


                                });
                              }),
                            ),

                          ],),2000
                      ),

                    ],
                  ),

                ],

              ),
            )
        );
      },
    );
  }
}
