import 'package:cached_network_image/cached_network_image.dart';
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

import '../../../../common_widget/custom_text_form.dart';

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
                            child: CachedNetworkImage(imageUrl: "${patientsAccountModel?.cover}",
                              fit: BoxFit.cover,
                              progressIndicatorBuilder: (context, url, downloadProgress) =>Container(height: 200,width: double.infinity,color: Colors.white),
                              errorWidget: (context, url, error) => Container(height: 200,width: double.infinity,color: Colors.white),

                            ),

                          ),0
                      ),
                      Positioned(
                        top: 130,
                        child: CustomAnimation(
                            Stack(
                              alignment: AlignmentDirectional.center,
                              children: [
Container(height: 125,width: 125,decoration: const BoxDecoration(
  color:
    Colors.white,shape: BoxShape.circle
),),

                                Container(clipBehavior: Clip.antiAliasWithSaveLayer,height: 120,width: 120,
                                    decoration: const BoxDecoration(
                                    color:
                                    Colors.white,shape: BoxShape.circle
                                ),child:                                 CachedNetworkImage(imageUrl: "${patientsAccountModel?.cover}",
                                  fit: BoxFit.cover,
                                  progressIndicatorBuilder: (context, url, downloadProgress) =>Container(height: 200,width: double.infinity,color: Colors.white),
                                  errorWidget: (context, url, error) => Container(height: 200,width: double.infinity,color: Colors.white),

                                ),),


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
                          controller.initLang.toString().contains("ar")?    Row(children: [

                          Expanded(
                            child: customOutlineButtom(const Icon(IconBroken.Logout),(){
                              GetStorage().remove("tokenOfPatients").then((value){
                                loginController.moveBetweenPages('PageSelectionDoctorOrPatient');


                              });
                            }),
                          ),

                          CustomSizeBox(0,width: 5,),
                          Expanded(
                            child: customOutlineButtom(const Icon(IconBroken.Edit),(){
                              controller.getPatientsData();
                              loginController.moveBetweenPages('UpdateProfilePatientsView');

                            }),
                          ),

                        ],):
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
