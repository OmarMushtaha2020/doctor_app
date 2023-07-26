import 'package:doctor_app/app/modules/home/controllers/register_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:doctor_app/app/modules/home/controllers/add_article_controller.dart';
import 'package:doctor_app/app/modules/home/controllers/layout_controller.dart';
import 'package:doctor_app/app/modules/home/controllers/login_controller.dart';
import 'package:doctor_app/app/modules/home/views/profile_view.dart';
import 'package:doctor_app/common_widget/custom_animation.dart';
import 'package:doctor_app/common_widget/custom_buttom.dart';
import 'package:doctor_app/common_widget/custom_size_box.dart';
import 'package:doctor_app/common_widget/custom_text.dart';
import 'package:doctor_app/common_widget/custom_text_form.dart';
import 'package:doctor_app/shared/styles/icon_broken.dart';

class HomeView extends GetView<LayoutController> {
  HomeView({Key? key}) : super(key: key);
  var nameCategories = TextEditingController();
  var detailsCategories = TextEditingController();
  var formKey = GlobalKey<FormState>();
  LoginController loginController = LoginController();

  @override
  Widget build(BuildContext context) {

    return GetBuilder<LayoutController>(
      init: LayoutController(),
      builder: (controller) {
        return Scaffold(
            floatingActionButton: FloatingActionButton(
              onPressed: () {
                controller.changeValueOfBottomSheet(true);
              },
              child: const Icon(IconBroken.Plus),
            ),
            body: controller.categories.length == 0
                ?
            Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const SpinKitFadingCube(
                        color: Colors.blue,
                        size: 50.0,
                      ),
                      CustomSizeBox(30),
                      CustomText(Colors.black, 15, FontWeight.w600,
                          "There is no category")
                    ],
                  )
                : ListView.separated(
                    shrinkWrap: true,
                    itemBuilder: (context, index) => Stack(
                          children: [
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 20),
                              child: Container(
                                width: double.infinity,
                                height: 120,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(20),
                                  color: const Color(0xFFfafafa),
                                ),
                                child: GestureDetector(
                                  onTap: () {
                                    AddArticleController article =
                                        AddArticleController();
                                    article
                                        .getAllArticle(
                                            controller.categories[index].id)
                                        .then((value) {
                                      loginController.moveBetweenPages(
                                          'AddArticleView',
                                          arguments: {
                                            "nameCategories": controller
                                                .categories[index]
                                                .nameCategories,
                                            "id":
                                                controller.categories[index].id,
                                          });
                                    });
                                  },
                                  child: Row(
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Container(
                                          height: 85,
                                          width: 85,
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(20),
                                            color: Colors.white,
                                            image: DecorationImage(
                                                image: NetworkImage(
                                                    "${controller.categories[index].imageCategories}"),
                                                fit: BoxFit.cover),
                                          ),
                                        ),
                                      ),
                                      CustomSizeBox(
                                        0,
                                        width: 20,
                                      ),
                                      Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          CustomText(
                                              Colors.black,
                                              20,
                                              FontWeight.w600,
                                              "${controller.categories[index].nameCategories}"),
                                          CustomSizeBox(10),
                                          CustomText(
                                              Colors.grey,
                                              12,
                                              FontWeight.w400,
                                              "${controller.categories[index].detailsCategories}"),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                            controller.categories[index].tokenOfDoctor ==
                                    tokenOfDoctors
                                ? layoutPatientsAppController.initLang
                                .toString()
                                .contains("ar")
                                    ? Positioned(
                                        left: 10,
                                        top: 20,
                                        child: customCircleAvatar(20,
                                            widget: const Icon(
                                              IconBroken.Delete,
                                              color: Colors.white,
                                            ),
                                            color: Colors.blue, onTap: () {
                                          controller.deleteCategories(
                                              controller.categories[index].id);
                                        }),
                                      )
                                    : Positioned(
                                        right: 10,
                                        top: 20,
                                        child: customCircleAvatar(20,
                                            widget: const Icon(
                                              IconBroken.Delete,
                                              color: Colors.white,
                                            ),
                                            color: Colors.blue, onTap: () {
                                          controller.deleteCategories(
                                              controller.categories[index].id);
                                        }),
                                      )
                                : Container(),
                          ],
                        ),
                    separatorBuilder: (controller, index) => CustomSizeBox(20),
                    itemCount: controller.categories.length),
            bottomSheet: controller.bottomSheet == true
                ? AnimatedContainer(
                    duration: const Duration(milliseconds: 20000),
                    curve: Curves.slowMiddle,
                    child: Container(
                      height: 300,
                      decoration: BoxDecoration(boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.1),
                          spreadRadius: 5,
                          blurRadius: 7,
                          offset: const Offset(0, 3),
                        ),
                      ]),
                      child: BottomSheet(
                          backgroundColor: Colors.white,
                          shape: const RoundedRectangleBorder(
                            borderRadius:
                                BorderRadius.vertical(top: Radius.circular(30)),
                          ),
                          onClosing: () {},
                          builder: (context) => Padding(
                                padding: const EdgeInsets.only(
                                    left: 30, right: 30, top: 40),
                                child: Form(
                                  key: formKey,
                                  child: SingleChildScrollView(
                                    child: Column(
                                      children: [
                                        CustomAnimation(
                                            CustomTextForm(
                                                nameCategories,
                                                "Name categories".tr,
                                                TextInputType.text,
                                                validator: (nameCategories) {
                                              if (nameCategories!.isEmpty) {
                                                return "Name Categories mustn't be empty"
                                                    .tr;
                                              }
                                            }),
                                            0),
                                        CustomSizeBox(15),
                                        CustomAnimation(
                                            Container(
                                              width: double.infinity,
                                              height: 50,
                                              decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(10),
                                                color: const Color(0xFFfafafa),
                                              ),
                                              child: Padding(
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                        horizontal: 13),
                                                child: Row(
                                                  children: [
                                                    const Icon(
                                                      IconBroken
                                                          .Arrow___Up_Square,
                                                      color: Color(0xffeb6b7bb),
                                                    ),
                                                    CustomSizeBox(
                                                      0,
                                                      width: 10,
                                                    ),
                                                    Expanded(

                                                      child: CustomText(

                                                        const Color(0xFFeb6b7bb),
                                                        16,
                                                        FontWeight.w400,
                                                        controller.imageCategorie !=
                                                                null
                                                            ? "${controller.imageCategorie!.path.substring(controller.imageCategorie!.path.lastIndexOf("-")).replaceAll("-", "")}"
                                                            : "Image Categories"
                                                                .tr,
                                                        onTap: () {
                                                          controller.getImage();
                                                        },
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ),
                                            500),
                                        CustomSizeBox(15),
                                        CustomAnimation(
                                            CustomTextForm(
                                                detailsCategories,
                                                "Details Categories".tr,
                                                TextInputType.text,
                                                validator: (detailsCategories) {
                                              if (detailsCategories!.isEmpty) {
                                                return "Details Categories mustn't be empty"
                                                    .tr;
                                              }
                                            }),
                                            1000),
                                        CustomSizeBox(15),
                                        CustomAnimation(
                                            CustomButtom(() {
                                              if (formKey.currentState!
                                                  .validate()) {
                                                controller
                                                    .addCategories(
                                                        nameCategories.text,
                                                        detailsCategories.text,
                                                        controller.valueOfImage)
                                                    .then((value) {
                                                  Future.delayed(const Duration(
                                                          milliseconds: 500))
                                                      .then((value) {
                                                    nameCategories.clear();
                                                    detailsCategories.clear();
                                                    controller.imageCategorie =
                                                        null;
                                                  });
                                                });
                                              }
                                            },
                                                Colors.blue,
                                                50,
                                                double.infinity,
                                                10,
                                                Colors.white,
                                                "Continue".tr,
                                                15),
                                            1500),
                                      ],
                                    ),
                                  ),
                                ),
                              )),
                    ),
                  )
                : null);
      },
    );
  }
}
