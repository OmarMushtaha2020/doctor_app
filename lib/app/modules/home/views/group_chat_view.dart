import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:doctor_app/app/modules/patients/controllers/layout_patients_app_controller.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:doctor_app/app/data/message_model.dart';
import 'package:doctor_app/app/modules/home/controllers/group_chat_controller.dart';
import 'package:doctor_app/app/modules/home/controllers/layout_controller.dart';
import 'package:doctor_app/app/modules/home/controllers/login_controller.dart';
import 'package:doctor_app/app/modules/home/controllers/register_controller.dart';
import 'package:doctor_app/app/modules/home/views/profile_view.dart';
import 'package:doctor_app/common_widget/custom_size_box.dart';
import 'package:doctor_app/common_widget/custom_text.dart';
import 'package:doctor_app/shared/styles/icon_broken.dart';

class GroupChatView extends GetView<GroupChatController> {
  GroupChatView({Key? key}) : super(key: key);
  var messageController = TextEditingController();
  LoginController loginController = LoginController();
  LayoutController layoutController = LayoutController();
  LayoutPatientsAppController layoutPatientsAppController =
      LayoutPatientsAppController();
  var argument = Get.arguments;

  @override
  Widget build(BuildContext context) {
    return Builder(builder: (context) {
      return GetBuilder<GroupChatController>(
        init: GroupChatController(),
        builder: (controller) {
          controller.getMessages(receiverId: argument['token']);
          return Scaffold(
              appBar: AppBar(
                title: Row(
                  children: [
                    GestureDetector(
                        onTap: () {
                          controller.changeValueOfIndex(1);
                        },
                        child: layoutPatientsAppController.initLang
                                .toString()
                                .contains("ar")
                            ? const Icon(
                                IconBroken.Arrow___Right_2,
                                color: Colors.black,
                              )
                            : const Icon(
                                IconBroken.Arrow___Left_2,
                                color: Colors.black,
                              )),
                    CustomSizeBox(
                      0,
                      width: 20,
                    ),
                    customCircleAvatar(25,
                        color: Colors.white, image: "${argument['cover']}"),
                    CustomSizeBox(
                      0,
                      width: 10,
                    ),
                    CustomText(
                        Colors.black, 20, FontWeight.w600, argument['name'])
                  ],
                ),
              ),
              body: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    Column(
                      children: [
                       Expanded(
                              child: SingleChildScrollView(
                                child: Column(
                                  children: [
                                    ListView.separated(
                                      scrollDirection: Axis.vertical,
                                      shrinkWrap: true,
                                      physics: const BouncingScrollPhysics(),
                                      itemBuilder: (BuildContext context, int index) {
                                        var message = controller.messages[index];
                                        if (tokenOfDoctors == message.senderId) {
                                          return buildMyMessage(message);
                                        }

                                        return buildMessage(message);
                                      },
                                      separatorBuilder:
                                          (BuildContext context, int index) =>
                                              const SizedBox(
                                        height: 15,
                                      ),
                                      itemCount: controller.messages.length,
                                    ),
                                  ],
                                ),
                              ),

                            ),
                        Padding(
                          padding: const EdgeInsets.only(top: 20),
                          child: Container(
                            clipBehavior: Clip.antiAliasWithSaveLayer,
                            height: 50,
                            padding: const EdgeInsetsDirectional.only(
                              start: 15,
                              end: 0,
                            ),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(12),
                                border: Border.all(
                                  color: Colors.grey,
                                )),
                            child: TextFormField(
                              maxLines: 999,
                              controller: messageController,
                              decoration: InputDecoration(
                                border: InputBorder.none,
                                hintText: 'Aa',
                                suffixIcon: MaterialButton(
                                  height: 10,
                                  padding: EdgeInsets.zero,
                                  onPressed: () async {
                                    controller.sendMessage(
                                      receiverId: argument['token'],
                                      dateTime: FieldValue.serverTimestamp(),
                                      text: messageController.text,
                                    );
                                  },
                                  color: Colors.blue,
                                  elevation: 10,
                                  minWidth: 1,
                                  child: const Icon(
                                    Icons.send,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),

                      ],),
                    controller.messages.isEmpty?                    const Center(child: Text("Never communicated before")):Container(),

                  ],
                ),



              ),
          );
        },
      );
    });
  }
}

Widget buildMessage(MessageModel model) => Align(
      alignment: AlignmentDirectional.centerStart,
      child: Container(
        decoration: BoxDecoration(
          color: Colors.grey[300],
          borderRadius: const BorderRadiusDirectional.only(
            bottomEnd: Radius.circular(
              10.0,
            ),
            topStart: Radius.circular(
              10.0,
            ),
            topEnd: Radius.circular(
              10.0,
            ),
          ),
        ),
        padding: const EdgeInsets.symmetric(
          vertical: 5,
          horizontal: 10,
        ),
        child: Text(model.text),
      ),
    );

Widget buildMyMessage(MessageModel model) => Align(
      alignment: AlignmentDirectional.centerEnd,
      child: Container(
        decoration: const BoxDecoration(
          color: Colors.blue,
          borderRadius: BorderRadiusDirectional.only(
            bottomStart: Radius.circular(
              10.0,
            ),
            topStart: Radius.circular(
              10.0,
            ),
            topEnd: Radius.circular(
              10.0,
            ),
          ),
        ),
        padding: const EdgeInsets.symmetric(
          vertical: 5.0,
          horizontal: 10.0,
        ),
        child: Text(
          model.text,
        ),
      ),
    );

