import 'package:doctor_app/app/modules/patients/controllers/layout_patients_app_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:doctor_app/app/modules/home/controllers/page_selection_doctor_or_patient_controller.dart';
import 'package:doctor_app/common_widget/custom_animation.dart';
import 'package:doctor_app/common_widget/custom_size_box.dart';
import 'package:doctor_app/common_widget/custom_text.dart';
import 'package:doctor_app/shared/styles/icon_broken.dart';


class PageSelectionDoctorOrPatientView extends GetView<PageSelectionDoctorOrPatientController> {
  LayoutPatientsAppController layoutPatientsAppController=LayoutPatientsAppController();
  @override
  Widget build(BuildContext context) {
    print("the initLang is${layoutPatientsAppController.initLang}");
    WidgetsBinding.instance.addPostFrameCallback((_) {
print("omar");
    });

    return GetBuilder<PageSelectionDoctorOrPatientController>(
      init: PageSelectionDoctorOrPatientController(),
      builder: (controller){
        return  Scaffold(
          backgroundColor: Colors.white,
appBar: AppBar(
toolbarHeight: 100,
  flexibleSpace: Stack(
    alignment: Alignment.topLeft,
    children: [
            Image.asset('assets/images/ellipse.png',color: Colors.blue,fit: BoxFit.cover,),
      Image.asset('assets/images/ellipse_2.png',color: Colors.blue,fit: BoxFit.cover,),

    ],
  ),
),
          body: Padding(
            padding:  const EdgeInsets.symmetric(horizontal: 100),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children:  [

                bulidContainerOfDoctor((){
                  controller.changeValue(false);

                },controller.value),
                CustomSizeBox(20),
                bulidContainerOfPatients((){
                  controller.changeValue(true);
                },controller.value),
              ],
            ),
          ),
          bottomSheet:               Container(
            color: Colors.white,
            height: 200,

            child: Align(
              alignment:layoutPatientsAppController.initLang==Locale("ar")?  AlignmentDirectional.bottomStart:AlignmentDirectional.bottomEnd,
              child: Stack(
                alignment:layoutPatientsAppController.initLang==Locale("ar")? AlignmentDirectional.bottomStart: AlignmentDirectional.bottomEnd,
                children: [
                  Transform.rotate(angle: 22,child: Image.asset('assets/images/ellipse.png',color: Colors.blue,)),
                  Transform.rotate(angle: 22,child: Image.asset('assets/images/ellipse_2.png',color: Colors.blue,)),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
  bulidContainerOfDoctor( void Function()onTap,bool value)=>            CustomAnimation(
     Container(height: 60.h,width: double.infinity,decoration: BoxDecoration(
      border: Border.all(color:value? Colors.blue:Colors.white,width: value?2:0),
        borderRadius: BorderRadius.circular(50.r),
        color: value ?Colors.white:Colors.blue,
    ),child: GestureDetector(
    onTap:onTap ,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CustomText(value?Colors.blue:Colors.white, 18.sp, FontWeight.w600, "Doctor".tr),
          CustomSizeBox(0.h,width: 10.w,),
           Icon(IconBroken.Profile,color: value?Colors.blue:Colors.white,),
        ],
      ),
    ),),500
  );
  bulidContainerOfPatients( void Function()onTap,bool value)=>            CustomAnimation(
     Container(height: 60.h,width: double.infinity,decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(50.r),
        color: value?Colors.blue:Colors.white,
        border: Border.all(color:value? Colors.white:Colors.blue,width: value?0:2)
    ),child: GestureDetector(
      onTap:onTap ,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CustomText(value?Colors.white:Colors.blue, 18.sp, FontWeight.w600, "Patients".tr),
          CustomSizeBox(0.h,width: 10.w,),
           Icon(IconBroken.Profile,color:value? Colors.white:Colors.blue),
        ],
      ),
    ),),1000
  );
}
