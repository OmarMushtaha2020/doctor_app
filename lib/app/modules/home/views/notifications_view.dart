import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:doctor_app/common_widget/custom_size_box.dart';
import 'package:doctor_app/common_widget/custom_text.dart';
import 'package:doctor_app/shared/styles/icon_broken.dart';

class NotificationsView extends GetView {
  const NotificationsView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:ListView.separated(padding: EdgeInsets.zero,itemBuilder: (context,index)=>Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Container(
          height: 100,
          decoration: BoxDecoration(
            color: Color(0xFFfafafa),

            borderRadius: BorderRadius.circular(10),
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Row(
              children: [
                Container(child:  Icon(IconBroken.Notification,color: Colors.white,),height: 50,width: 50,decoration: BoxDecoration(
                  color: Colors.blue,
                  borderRadius: BorderRadius.circular(10),
                ),),
                CustomSizeBox(0,width: 15,),
                Column(crossAxisAlignment: CrossAxisAlignment.start,mainAxisAlignment: MainAxisAlignment.center,children: [
                  CustomText(Colors.black, 17, FontWeight.w600, "Darlene Steward"),
                  CustomText(Colors.grey, 14, FontWeight.w400, "Pls take a look at the images."),

                ],),
             Spacer(),
                Icon(Icons.cancel_outlined)
              ],
            ),
          ),
        ),
      ), separatorBuilder: (context,index)=>CustomSizeBox(20), itemCount: 20),
    );
  }
}
