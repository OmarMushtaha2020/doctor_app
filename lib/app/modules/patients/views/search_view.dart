import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:doctor_app/app/modules/home/controllers/login_controller.dart';
import 'package:doctor_app/app/modules/home/views/profile_view.dart';
import 'package:doctor_app/app/modules/patients/controllers/search_controller.dart';
import 'package:doctor_app/common_widget/custom_animation.dart';
import 'package:doctor_app/common_widget/custom_size_box.dart';
import 'package:doctor_app/common_widget/custom_text.dart';
import 'package:doctor_app/common_widget/custom_text_form.dart';
import 'package:doctor_app/shared/styles/icon_broken.dart';

import '../controllers/article_controller.dart';

class SearchView extends GetView<SearchController> {

   SearchView({Key? key}) : super(key: key);
   LoginController loginController=LoginController();
   ArticleController articleController=ArticleController();
var nameOfCategory=TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: GetBuilder<SearchController>(
            init: SearchController(),
            builder: (controller){
              return  Column(
                children: [
                  Row(
                    children: [
                      GestureDetector(onTap: (){
                        articleController.changeValueOfHomePatients(true);
                        loginController.moveBetweenPages('LayoutPatientsAppView');
                      },child: Icon(IconBroken.Arrow___Left_2,color: Colors.black,)),
                      CustomSizeBox(0,width: 20,),
                      CustomText(Colors.black,22,FontWeight.w600,"Search for category".tr),
                    ],
                  ),
                  CustomSizeBox(30),
                  CustomAnimation(
                      CustomTextForm(nameOfCategory, "Enter Name Of Category".tr, TextInputType.text,onChanged: (name){
                        controller.getAllSearchCategory(name);
                      },),500
                  ),
                  CustomSizeBox(30),
                  nameOfCategory.text.isEmpty? Padding(
                    padding: const EdgeInsets.only(top: 300),
                    child: CustomText(Colors.black, 20, FontWeight.w600, "Please enter a category name".tr),
                  )  :controller.searchCategories.length==0?Padding(
                    padding: const EdgeInsets.only(top: 300),
                    child: CustomText(Colors.black, 20, FontWeight.w600, "There is no category with this name"),
                  ) :ListView.separated(shrinkWrap: true,itemBuilder: (context,index)=>
                      Stack(
                        alignment: AlignmentDirectional.topEnd,
                        children: [
                          Container(width: double.infinity,height: 120,decoration: BoxDecoration(

                            borderRadius: BorderRadius.circular(20),
                            color: const Color(0xFFfafafa),

                          ),child:GestureDetector(
                            onTap: (){
                              ArticleController article=ArticleController();
                              article.getAllArticle( controller.searchCategories[index].id);
                              loginController.moveBetweenPages('ArticleView',arguments:{
                                "nameCategories": controller.searchCategories[index].nameCategories,
                                "id": controller.searchCategories[index].id,
                              });
                            },
                            child: Row(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(left: 10),
                                  child: Container(height: 85,width: 85,decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(20),color: Colors.white,
                                    image:  DecorationImage(image: NetworkImage("${controller.searchCategories[index].imageCategories}"),fit: BoxFit.cover),
                                  ),),
                                ),
                                CustomSizeBox(0,width: 20,),

                                Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    SingleChildScrollView(child: CustomText(Colors.black,20,FontWeight.w600,"${controller.searchCategories[index].nameCategories}")),
                                    CustomSizeBox(10),

                                    CustomText(Colors.grey,12,FontWeight.w400,"${controller.searchCategories[index].detailsCategories}"),

                                  ],
                                ),
                                const Spacer(),
                                Padding(

                                  padding: const EdgeInsets.only(right:10 ),
                                  child: customCircleAvatar(
                                      20,
                                      color: controller.searchCategories[index].like==false?Colors.grey:Colors.blue,
                                      widget:       const Icon(IconBroken.Star,color: Colors.white,),
                                      onTap: (){
                                        controller.updateCategories(controller.searchCategories[index].idOfMyCategories,nameOfCategory.text);
                                      }
                                  ),
                                ),

                              ],
                            ),
                          )
                            ,),
                        ],
                      ), separatorBuilder: (controller,index)=>CustomSizeBox(20), itemCount: controller.searchCategories.length),

                ],
              );
            },
          ),
        ),
      )
    );
  }
}
