import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

import 'package:get/get.dart';
import 'package:doctor_app/app/modules/home/controllers/group_chat_controller.dart';
import 'package:doctor_app/app/modules/home/controllers/layout_controller.dart';
import 'package:doctor_app/app/modules/home/controllers/login_controller.dart';
import 'package:doctor_app/app/modules/home/views/profile_view.dart';
import 'package:doctor_app/common_widget/custom_size_box.dart';
import 'package:doctor_app/common_widget/custom_text.dart';

class ChatView extends GetView<LayoutController> {
  ChatView({Key? key}) : super(key: key);
  LoginController loginController = LoginController();

  @override
  Widget build(BuildContext context) {

    return GetBuilder<LayoutController>(
      init: LayoutController(),
      builder: (controller) {
        return Scaffold(
            body: patients.length == 0
                ? Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const SpinKitFadingCube(
                        color: Colors.blue,
                        size: 50.0,
                      ),
                      CustomSizeBox(30),
                      CustomText(Colors.black, 15, FontWeight.w600,
                          "There is no patients")
                    ],
                  )
                : Padding(
                    padding: const EdgeInsets.only(top: 10, bottom: 10),
                    child: ListView.separated(
                        padding: EdgeInsets.zero,
                        physics: const BouncingScrollPhysics(),
                        itemBuilder: (context, index) => Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 20),
                              child: Row(
                                children: [
                                  Stack(
                                    clipBehavior: Clip.none,
                                    alignment: AlignmentDirectional.bottomEnd,
                                    children: [
                                      GestureDetector(onTap: (){

                                        GroupChatController group =
                                        GroupChatController();
                                        final groupChat = Get.lazyPut(
                                                () => GroupChatController());
                                        GroupChatController
                                        groupChatController =
                                        GroupChatController();
                                        groupChatController.getMessages(
                                            receiverId: patients[index].token);
                                        loginController.moveBetweenPages(
                                            'GroupChatView',
                                            arguments: {
                                              "token": patients[index].token,
                                              "cover": patients[index].cover,
                                              "name": patients[index].name,
                                            });
                                      },child: Container(clipBehavior: Clip.antiAliasWithSaveLayer,width: 50,height: 50,decoration: const BoxDecoration(shape: BoxShape.circle),child:  CachedNetworkImage(imageUrl: "https://images.unsplash.com/photo-1575936123452-b67c3203c357?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8Mnx8aW1hZ2V8ZW58MHx8MHx8fDA%3D&w=1000&q=80",
                                        fit: BoxFit.cover,
                                        progressIndicatorBuilder: (context, url, downloadProgress) =>Container(height: 85,width: 85,color: Colors.white),
                                        errorWidget: (context, url, error) => Container(height: 85,width: 85,color: Colors.white),

                                      ),)),

                                      Stack(
                                        alignment: AlignmentDirectional.center,
                                        children: [
                                          Container(height: 20,width: 20,decoration: const BoxDecoration(
                                            shape: BoxShape.circle,
                                            color: Colors.white,


                                          ),),

                                          Container(height:15,width: 15,decoration: const BoxDecoration(
                                            shape: BoxShape.circle,
                                            color: Colors.blue,


                                          ),),

                                        ],
                                      )
                                    ],
                                  ),
                                  CustomSizeBox(
                                    0,
                                    width: 10,
                                  ),
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      CustomText(
                                          Colors.black,
                                          17,
                                          FontWeight.w600,
                                          "${patients[index].name}"),
                                      CustomText(Colors.grey, 14,
                                          FontWeight.w400, "omar"),
                                    ],
                                  ),
                                  const Spacer(),
                                  CustomText(const Color(0xff333333), 14,
                                      FontWeight.w400, "06:12")
                                ],
                              ),
                            ),
                        separatorBuilder: (context, index) => CustomSizeBox(20),
                        itemCount: patients.length),
                  ));
      },
    );
  }
}
