import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

import 'package:get/get.dart';
import 'package:doctor_app/app/modules/home/controllers/login_controller.dart';
import 'package:doctor_app/app/modules/home/views/profile_view.dart';
import 'package:doctor_app/app/modules/patients/controllers/article_controller.dart';
import 'package:doctor_app/app/modules/patients/controllers/layout_patients_app_controller.dart';
import 'package:doctor_app/common_widget/custom_size_box.dart';
import 'package:doctor_app/common_widget/custom_text.dart';
import 'package:doctor_app/shared/styles/icon_broken.dart';

class SubscriptionsView extends GetView<LayoutPatientsAppController> {
   SubscriptionsView({Key? key}) : super(key: key);
  LoginController loginController=LoginController();
  @override
  Widget build(BuildContext context) {

    return GetBuilder<LayoutPatientsAppController>(
      init: LayoutPatientsAppController(),
      builder: (controller){
        return  Scaffold(
          body:  controller.subsriptions.length==0? Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const SpinKitFadingCube(
                color: Colors.blue,

                size: 50.0,
              ),
              CustomSizeBox(30),
              CustomText(Colors.black, 15, FontWeight.w600, "There is no Subscriptions")
            ],
          ):ListView.separated(shrinkWrap: true,itemBuilder: (context,index)=>
              Stack(
                alignment: AlignmentDirectional.topEnd,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Container(width: double.infinity,height: 120,decoration: BoxDecoration(

                      borderRadius: BorderRadius.circular(20),
                      color: const Color(0xFFfafafa),

                    ),child:GestureDetector(
                      onTap: (){
                        ArticleController article=ArticleController();
                        article.getAllArticle( controller.categories[index].id);
                        loginController.moveBetweenPages('ArticleView',arguments:{
                          "nameCategories": controller.categories[index].nameCategories,
                          "id": controller.categories[index].id,
                        });
                      },
                      child: Row(
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Container(clipBehavior: Clip.antiAliasWithSaveLayer,height: 85,width: 85,decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),color: Colors.white,
                            ),child:  CachedNetworkImage(imageUrl: "${controller.subsriptions[index].imageCategories}",
                              fit: BoxFit.cover,
                              progressIndicatorBuilder: (context, url, downloadProgress) =>Container(height: 85,width: 85,color: Colors.white),
                              errorWidget: (context, url, error) => Container(height: 85,width: 85,color: Colors.white),

                            ),),
                          ),
                          CustomSizeBox(0,width: 20,),

                          Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              CustomText(Colors.black,20,FontWeight.w600,"${controller.subsriptions[index].nameCategories}"),
                              CustomSizeBox(10),

                              CustomText(Colors.grey,12,FontWeight.w400,"${controller.subsriptions[index].detailsCategories}"),

                            ],
                          ),
                          const Spacer(),
                          Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: GestureDetector(
                                onTap: (){
                                  controller.updateCategories(controller.subsriptions[index].idOfMyCategories,index);

                                },
                                child: Container(
                                  width: 40,
                                  height: 40,
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    color:   controller.subsriptions[index].like==false?Colors.grey:Colors.blue,
                                  ),
                                  child: const Icon(IconBroken.Star,color: Colors.white,),
                                ),
                              )

                          ),



                        ],
                      ),
                    )
                      ,),
                  ),
                ],
              ), separatorBuilder: (controller,index)=>CustomSizeBox(20), itemCount: controller.subsriptions.length),
        );
      },
    );
  }
}
