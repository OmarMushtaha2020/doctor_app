import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:doctor_app/app/modules/home/controllers/login_controller.dart';
import 'package:doctor_app/app/modules/home/controllers/register_controller.dart';
import 'package:doctor_app/app/modules/home/views/profile_view.dart';
import 'package:doctor_app/app/modules/patients/controllers/layout_patients_app_controller.dart';
import 'package:doctor_app/app/modules/patients/controllers/update_profile_patients_controller.dart';
import 'package:doctor_app/common_widget/custom_animation.dart';
import 'package:doctor_app/common_widget/custom_size_box.dart';
import 'package:doctor_app/common_widget/custom_text.dart';
import 'package:doctor_app/common_widget/custom_text_buttom.dart';
import 'package:doctor_app/common_widget/custom_text_form.dart';
import 'package:doctor_app/shared/styles/icon_broken.dart';

class UpdateProfilePatientsView extends GetView<UpdateProfilePatientsController> {
   UpdateProfilePatientsView({Key? key}) : super(key: key);
   var name=TextEditingController();
   var bio=TextEditingController();
   var phone=TextEditingController();
   var formKey=GlobalKey<FormState>();

   LoginController loginController=LoginController();
   LayoutPatientsAppController layoutPatientsAppController=LayoutPatientsAppController();
  @override
  Widget build(BuildContext context) {
    name.text=patientsAccountModel?.name;
    bio.text=patientsAccountModel?.bio;
    phone.text=patientsAccountModel?.phone;
    return GetBuilder<UpdateProfilePatientsController>(
      init: UpdateProfilePatientsController(),
      builder: (controller){
        return Scaffold(
            appBar: AppBar(
              title: Row(
                children: [
                  GestureDetector(onTap: (){
LayoutPatientsAppController layout=LayoutPatientsAppController();
layout.changeValueOfIndex(3);
                    loginController.moveBetweenPages('LayoutPatientsAppView');
                  },child: layoutPatientsAppController.initLang==const Locale("ar")?const Icon(IconBroken.Arrow___Right_2,color: Colors.black,):const Icon(IconBroken.Arrow___Left_2,color: Colors.black,)),
                  CustomSizeBox(0,width: 20,),

                  CustomText(Colors.black, 18, FontWeight.w600, "Edit Profile".tr),

                ],
              ),
              actions: [
                Padding(
                  padding: const EdgeInsets.only(right: 5),
                  child: CustomTextButtom(() {
    if(formKey.currentState!.validate()) {

      controller.updatePatientsData(name: name.text, phone: phone.text, bio: bio.text).then((value) {
        final layoutPatientsAppController =Get.lazyPut(()=>LayoutPatientsAppController());
        var latout=Get.find<LayoutPatientsAppController>();
        loginController.moveBetweenPages('LayoutPatientsAppView');

        latout.getPatientsData ();
      });

    }
                  }, "UPDATE".tr, Colors.blue, 15, FontWeight.w400),
                )
              ],
              centerTitle: true,
            ),
            body:Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10,vertical: 10),
              child: Form(
                key: formKey,
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      Stack(
                        alignment: AlignmentDirectional.bottomCenter,
                        clipBehavior: Clip.none,
                        children: [
                          CustomAnimation(
                              Stack(
                                alignment: AlignmentDirectional.topEnd,
                                children: [
                                  Container(
                                    width: double.infinity,
                                    height: 200,

                                    child: controller.coverImage == null
                                        ? CachedNetworkImage(
                                      fit: BoxFit.cover,
                                      imageUrl: "${patientsAccountModel?.cover}",
                                      progressIndicatorBuilder: (context, url, downloadProgress) =>
                                      const SizedBox(width: double.infinity,height: 200),
                                      errorWidget: (context, url, error) =>  const SizedBox(width: double.infinity,height: 200),
                                    ):Image.file(controller.coverImage!,fit: BoxFit.cover,),
                                  ),



                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: GestureDetector(
                                      onTap: () {
                                        controller.getCoverImage(
                                            name.text, phone.text, bio.text);
                                      },
    child:
                                      Container(
                                        height: 40,width: 40,
                                        child:  const Icon(IconBroken.Camera,color: Colors.white,),
                                        decoration: const BoxDecoration(
                                            shape: BoxShape.circle,
                                            color: Colors.blue
                                        ),
                                      ),

                                  ),
                                  ),


                                ],
                              ),0
                          ),
                          Positioned(
                            top: 130,
                            child: CustomAnimation(
                                Stack(
                                  alignment: AlignmentDirectional.bottomEnd,
                                  children: [
                                    GestureDetector(
                                      onTap: () {
                                        controller.getProfileImage(name.text,phone.text,bio.text);

                                      },
                                      child: Stack(
                                        alignment: AlignmentDirectional.center,
                                        children: [
                                          Container(
                                            width: 125,
                                            clipBehavior: Clip.antiAliasWithSaveLayer,
                                            height: 125,
                                            decoration: const BoxDecoration(
                                                shape: BoxShape.circle,
                                                color: Colors.white
                                            ),

                                          ),
                                          Container(
                                            width: 120,
                                            clipBehavior: Clip.antiAliasWithSaveLayer,
                                            height: 120,
                                            decoration: const BoxDecoration(
                                                shape: BoxShape.circle
                                            ),
                                            child: controller
                                                .profileImage ==
                                                null? CachedNetworkImage(
                                              fit: BoxFit.cover,
                                              imageUrl: "${patientsAccountModel?.image}",
                                              progressIndicatorBuilder: (context, url, downloadProgress) =>
                                              const SizedBox(width: double.infinity,height: 200),
                                              errorWidget: (context, url, error) =>  const SizedBox(width: double.infinity,height: 200),
                                            ):Image.file(controller
                                                .profileImage!,fit: BoxFit.cover,),

                                          ),

                                        ],
                                      ),
                                    ),
                                  ],
                                ),


                                500
                            ),
                          )
                        ],
                      ),
                      CustomSizeBox( 80,),

                      Column(
                        children: [
                          CustomAnimation(
                            CustomTextForm(
                                name, "Enter your name".tr,TextInputType.name, validator: (name){
                              if(name!.isEmpty){
                                return "name mustn't be empty".tr;

                              }
                              return null;
                            }),1000,
                          ),
                          CustomSizeBox(10),
                          CustomAnimation(
                            CustomTextForm(
                                bio, "Enter your bio".tr,TextInputType.text, validator: (bio){
                              if(bio!.isEmpty){
                                return "bio mustn't be empty".tr;

                              }
                              return null;
                            }),1500,
                          ),
                          CustomSizeBox(10),

                          CustomAnimation(
                            CustomTextForm(
                                phone, "Enter your phoneNumber".tr,TextInputType.phone, validator: (phone){
                              if(phone!.isEmpty){
                                return "phoneNumber mustn't be empty".tr;

                              }
                              return null;
                            }),2000,
                          ),

                        ],
                      ),

                    ],

                  ),
                ),
              ),
            )
        );
      },
    );
  }
}
