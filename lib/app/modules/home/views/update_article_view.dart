import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:doctor_app/app/modules/home/controllers/login_controller.dart';
import 'package:doctor_app/app/modules/home/controllers/update_article_controller.dart';
import 'package:doctor_app/app/modules/home/views/profile_view.dart';
import 'package:doctor_app/common_widget/custom_animation.dart';
import 'package:doctor_app/common_widget/custom_size_box.dart';
import 'package:doctor_app/common_widget/custom_text_form.dart';
import 'package:doctor_app/shared/styles/icon_broken.dart';

import '../../../../common_widget/custom_buttom.dart';

class UpdateArticleView extends GetView<UpdateArticleController> {
   UpdateArticleView ({Key? key}) : super(key: key);
  LoginController login=LoginController();
   var formKey=GlobalKey<FormState>();
   var articleName=TextEditingController();
   var articleDetails=TextEditingController();

   var argument=Get.arguments;
  @override
  Widget build(BuildContext context) {
    articleName.text=argument['name'];
    articleDetails.text=argument['details'];

    print(argument['id']);
    print(argument['idOfArticle']);

    return GetBuilder<UpdateArticleController>(
      init: UpdateArticleController(),
      builder: (controller){
        return Scaffold(
            body: Form(
              key: formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Stack(
                    children: [

                      Image(image:NetworkImage("${argument['image']}"),height: 400,width: double.infinity,fit: BoxFit.cover,),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20,vertical: 60),
                        child: Row(
                          children: [
                            Container(width: 50,height: 50,decoration: BoxDecoration(
                              color: Colors.white,

                              borderRadius: BorderRadius.circular(10),
                            ),child: const Icon(IconBroken.Arrow___Left_2),),
                            Spacer(),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: customCircleAvatar(18,color:Colors.blue,widget: const Icon(IconBroken.Camera),onTap: (){
                                controller.getImage();
                              }),
                            ),

                          ],
                        ),
                      ),

                    ],
                  ),
                  CustomSizeBox(20),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 30),
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

                                  contentPadding: EdgeInsets.only(left: 15),
                                  hintText: "Article details".tr,
                                  hintStyle: TextStyle(
                                      color: Color(0xFFeb6b7bb)
                                  ),
                                ),
                              ),
                            ),500
                        ),
                        CustomSizeBox(15),


                        CustomAnimation(
                            CustomButtom(() {
                              if(formKey.currentState!.validate()){
                                controller.updateArticle(articleName.text, articleDetails.text, controller.valueOfImage,argument['id'] ,argument['idOfArticle']).then((value){
                                  login.moveBetweenPages('AddArticleView',arguments: {"id":argument['id'],"nameCategories":argument['nameCategories']});
                              });
                            }
                            }, Colors.blue, 50, double.infinity, 10,
                                Colors.white, "Continue".tr, 15),1000
                        ),

                      ],
                    ),
                  ),

                ],
              ),
            )
        );
      },
    );
  }
}
