import 'package:doctor_app/app/modules/patients/controllers/layout_patients_app_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

import 'package:get/get.dart';
import 'package:doctor_app/app/modules/home/controllers/add_article_controller.dart';
import 'package:doctor_app/app/modules/home/controllers/login_controller.dart';
import 'package:doctor_app/app/modules/home/controllers/register_controller.dart';
import 'package:doctor_app/common_widget/custom_animation.dart';
import 'package:doctor_app/common_widget/custom_buttom.dart';
import 'package:doctor_app/common_widget/custom_size_box.dart';
import 'package:doctor_app/common_widget/custom_text.dart';
import 'package:doctor_app/common_widget/custom_text_form.dart';
import 'package:doctor_app/shared/styles/icon_broken.dart';
bool bottomSheetOfArticle=false;
class AddArticleView extends GetView<AddArticleController> {
   AddArticleView({Key? key}) : super(key: key);
   var argument=Get.arguments;
   var formKey=GlobalKey<FormState>();
   var articleName=TextEditingController();
   LoginController loginController=LoginController();
LayoutPatientsAppController layoutPatientsAppController=LayoutPatientsAppController();
   var articleDetails=TextEditingController();
  @override
  Widget build(BuildContext context) {
    controller.getAllArticle('${argument['id']}');

    return GetBuilder<AddArticleController>(

      init: AddArticleController(),
      builder: (controller){
        return Scaffold(
          floatingActionButton: FloatingActionButton(onPressed: (){
            controller.changeValueOfBottomSheet(true);
          },child: const Icon(IconBroken.Plus),),
          appBar: AppBar(
            title: Row(
              children: [
                GestureDetector(onTap: (){
// controller.changeValueOfHome(true).then((value){
  loginController.moveBetweenPages('layout');

// });
                },child: layoutPatientsAppController.initLang==const Locale("ar") ?const Icon(IconBroken.Arrow___Right_2,color: Colors.black,):const Icon(IconBroken.Arrow___Left_2,color: Colors.black,))
                ,CustomSizeBox(0,width: 20,),
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
                loginController.moveBetweenPages('ArticleDetailsView',arguments: {
                  "image":controller.article[index].image,
                  "id":argument['id'],
                  "idOfArticle":controller.article[index].idOfArticle,
                  "nameCategories":argument['nameCategories'],
                  "name":controller.article[index].name,
                  "details":controller.article[index].details
                });
              },
              child: Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 10),
                    child: Container(height: 85,width: 85,decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),color: Colors.white,
                      image:  DecorationImage(image: NetworkImage("${controller.article[index].image}"),fit: BoxFit.cover),
                    ),),
                  ),
                  CustomSizeBox(0,width: 20,),
                  CustomText(Colors.black,20,FontWeight.w600,"${controller.article[index].name}"),
const Spacer(),
                 controller.article[index].tokonofDoctor==tokenOfDoctors?
                 Padding(
                    padding:layoutPatientsAppController.initLang==Locale("ar")?const EdgeInsets.only(left: 10):const EdgeInsets.only(right: 10),
                    child: GestureDetector(onTap: (){
                      loginController.moveBetweenPages('UpdateArticleView',arguments: {
                        "image":controller.article[index].image,
                        "id":argument['id'],
                        "idOfArticle":controller.article[index].idOfArticle,
                        "nameCategories":argument['nameCategories'],
                        "name":controller.article[index].name,
                        "details":controller.article[index].details
                      });

                    },child: const Icon(IconBroken.Edit_Square)),
                  ):Container(),
                ],
              ),
            )
              ,),
          ), separatorBuilder: (controller,index)=>CustomSizeBox(20,), itemCount: controller.article.length),
          bottomSheet:             controller.bottomSheet==true?    Container(
            height: 500,
            decoration: BoxDecoration(
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.1),
                    spreadRadius: 5,
                    blurRadius: 7,
                    offset: const Offset(0, 3),
                  ),
                ]
            ),
            child:  BottomSheet(
                backgroundColor:           Colors.white,
                shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.vertical(top: Radius.circular(30)),
                ),
                onClosing: () {},
                builder: (context) => Padding(
                  padding: const EdgeInsets.only(left: 30,right: 30,top: 40),
                  child: Form(
                    key: formKey,
                    child: SingleChildScrollView(
                      child: Column(
                        children: [
                          CustomAnimation( CustomTextForm(articleName, "Article Name".tr,TextInputType.text,
                              validator: (articleName){
                                if(articleName!.isEmpty){
                                  return "Article Name mustn't be empty".tr;

                                }
                              }),0),
                          CustomSizeBox(15),
                          CustomAnimation(
                              Container(width: double.infinity,height: 50,decoration:  BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color:          const Color(0xFFfafafa),
                              ),child: Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 13),
                                child: Row(
                                  children:  [
                                    const Icon(IconBroken.Arrow___Up_Square,              color: Color(0xffeb6b7bb),),
                                    CustomSizeBox(0,width: 10,),
                                    CustomText(               const Color(0xffeb6b7bb), 16, FontWeight.w400, "Image Article".tr,onTap: (){
                                      controller.getImage();
                                    },),
                                  ],
                                ),
                              ),),500
                          ),
                          CustomSizeBox(15),
                      CustomAnimation(
                         Container(
                          decoration: BoxDecoration(
                              color: const Color(0xFFfafafa),
                              borderRadius: BorderRadius.circular(10)
                          ),
                          child: TextFormField(
maxLength: 600,
                            maxLines: 12,

                            controller: articleDetails,
                            keyboardType:TextInputType.text ,
                            validator:(validator){
                              if(validator!.isEmpty){
                                return "Article details mustn't be empty".tr;

                              }
                            },

                            decoration:  InputDecoration(

                              border: InputBorder.none,

                              contentPadding: const EdgeInsets.only(left: 15),
                              hintText: "Article details".tr,
                              hintStyle: const TextStyle(
                                  color: Color(0xffeb6b7bb)
                              ),
                            ),
                          ),
                        ),1000
                      ),
                          CustomSizeBox(15),


                          CustomAnimation(
                              CustomButtom(() {
                                if(formKey.currentState!.validate()){
controller.addArticle(articleName.text, articleDetails.text, controller.valueOfImage, argument['id']).then((value){

});
                                }
                              }, Colors.blue, 50, double.infinity, 10,
                                  Colors.white, "Continue".tr, 15),1500
                          ),

                        ],
                      ),
                    ),
                  ),
                )
            ),
          ):null,
        );
      },
    );
  }
}
