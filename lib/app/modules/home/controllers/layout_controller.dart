import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:doctor_app/app/data/categories_model.dart';
import 'package:doctor_app/app/data/doctor_account_model.dart';
import 'package:doctor_app/app/data/message_model.dart';
import 'package:doctor_app/app/data/patients_account_model.dart';
import 'package:doctor_app/app/modules/home/controllers/add_article_controller.dart';
import 'package:doctor_app/app/modules/home/controllers/create_password_controller.dart';
import 'package:doctor_app/app/modules/home/controllers/group_chat_controller.dart';
import 'package:doctor_app/app/modules/home/controllers/register_controller.dart';
import 'package:doctor_app/app/modules/home/views/chat_view.dart';
import 'package:doctor_app/app/modules/home/views/home_view.dart';
import 'package:doctor_app/app/modules/home/views/notifications_view.dart';
import 'package:doctor_app/app/modules/home/views/profile_view.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:doctor_app/app/modules/patients/controllers/layout_patients_app_controller.dart';

var index = 0;
List<PatientsAccountModel> patients = [];
AddArticleController addArticleController = AddArticleController();
GroupChatController groupChatController = GroupChatController();

class LayoutController extends GetxController {
  bool bottomSheet = false;
  List screen = [
    HomeView(),
    ChatView(),
    NotificationsView(),
    ProfileView(),
  ];

  List titleOfScreen = [
    'Home'.tr,
    'Chat'.tr,
    'Notification'.tr,
    'Profile'.tr,
  ];

  @override
  void onInit() {
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }

  Future<void> changeValueOfIndex(value) async {
    index = value;
    bottomSheet = false;
    if (index == 0) {
      getAllCategories();
    }
    if (index == 1) {
      getAllAccountPatients();

      update();
    }
    if (index == 2) {}
    if (index == 3) {
      getDoctorsData();

      update();
    }
    print(index);
    update();
  }

  Future<void> getAllAccountPatients() async {
    patients = [];
    FirebaseFirestore.instance.collection("patients").get().then((value) {
      value.docs.forEach((element) {
        patients.add(PatientsAccountModel.formJson(element.data()));

        update();

        print(patients.length);
      });
      update();
    });
    update();
  }

  Future<void> getDoctorsData() async {
    FirebaseFirestore.instance
        .collection("doctors")
        .doc(tokenOfDoctors)
        .get()
        .then((value) {
      doctorAccountModel = DoctorAccountModel.formJson(value.data()!);
      print("The User is${doctorAccountModel?.name.toString()}");
      update();
    });
    update();
  }

  Future<void> getLastMessageWithPatients(token, value) async {
    chats = [];
    FirebaseFirestore.instance
        .collection("doctors")
        .doc(tokenOfDoctors)
        .collection("patients")
        .doc("$token")
        .collection("messages")
        .where("value", isEqualTo: value)
        .get()
        .then((value) {
      value.docs.forEach((element) {
        chats.add(MessageModel.fromJson(element.data()));

        update();
        print(chats[0].text);
      });
    });

    update();
  }

  Future<void> changeValueOfBottomSheet(bool value) async {
    bottomSheet = value;
    update();
  }

  List<CategoriesModel> categories = [];

  void getAllCategories() {
    categories = [];
    FirebaseFirestore.instance.collection("Categories").get().then((value) {
      value.docs.forEach((element) {
        categories.add(CategoriesModel.fromJson(element.data()));
        update();
      });
    });
  }

  CategoriesModel? categoriesModel;

  Future<void> addCategories(
      nameCategories, detailsCategories, imageCategories) async {
    if (nameCategories != null &&
        detailsCategories != null &&
        imageCategorie?.path.length != 0) {
      categoriesModel = CategoriesModel(nameCategories, detailsCategories,
          imageCategories, false, tokenOfDoctors);
      Future.delayed(Duration(milliseconds: 1000)).then((value) {
        FirebaseFirestore.instance
            .collection("Categories")
            .where("nameCategories", isEqualTo: nameCategories)
            .get()
            .then((value) {
          if (value.docs.length == 0) {
            FirebaseFirestore.instance
                .collection("Categories")
                .add(categoriesModel?.toMap() ?? {})
                .then((values) {
              FirebaseFirestore.instance
                  .collection("Categories")
                  .doc(values.id)
                  .update({"id": values.id}).then((value) {
                FirebaseFirestore.instance
                    .collection("patients")
                    .get()
                    .then((value) {
                  if (value.docs.length != 0) {
                    value.docs.forEach((element) {
                      update();

                      print(value.docs.length);
                      print("!");
                      update();
                      categoriesModel = CategoriesModel(
                          nameCategories,
                          detailsCategories,
                          imageCategories,
                          false,
                          tokenOfDoctors,
                          id: values.id);
                      FirebaseFirestore.instance
                          .collection('patients')
                          .doc(element.data()['token'])
                          .collection("myCategories")
                          .add(categoriesModel?.toMap() ?? {})
                          .then((value) {
                        update();

                        FirebaseFirestore.instance
                            .collection('patients')
                            .doc(element.data()['token'])
                            .collection("myCategories")
                            .doc(value.id)
                            .update({"idOfMyCategories": value.id}).then(
                                (value) {
                          update();
                        });
                      });
                    });
                    changeValueOfBottomSheet(false).then((value) {
                      getAllCategories();
                      valueOfImage = '';
                      print("valueOfImage is${valueOfImage?.length}");
                      update();
                    });
                  }
                });
              });
              print(values.id);
              update();
            }).catchError((error) {});
          }
        });
        update();
      });
      update();
    }

    update();
  }

  var picker = ImagePicker();
  File? imageCategorie;

  Future<void> getImage() async {
    imageCategorie = null;
    final pickedFile = await picker.getImage(
      source: ImageSource.gallery,
    );

    if (pickedFile != null) {
      imageCategorie = File(pickedFile.path);
      print("The path is${imageCategorie!.path}");
      uploadImage();
      update();
    } else {
      print('No image selected.');
    }
  }

  String? valueOfImage;

  void uploadImage() {
    firebase_storage.FirebaseStorage.instance
        .ref()
        .child('Categories/${Uri.file(imageCategorie!.path).pathSegments.last}')
        .putFile(imageCategorie!)
        .then((value) {
      value.ref.getDownloadURL().then((value) {
        valueOfImage = value;
        print("the value is $valueOfImage");
        update();
      }).catchError((error) {});
    }).catchError((error) {});
  }

  Future<void> deleteCategories(id) async {
    FirebaseFirestore.instance
        .collection("Categories")
        .doc('$id')
        .delete()
        .then((value) {
      FirebaseFirestore.instance
          .collection("Categories")
          .doc('$id')
          .collection("Article")
          .get()
          .then((value) {
        value.docs.forEach((element) {
          FirebaseFirestore.instance
              .collection("Categories")
              .doc('$id')
              .collection("Article")
              .where("idOfCategories",
                  isEqualTo: element.data()['idOfCategories'])
              .get()
              .then((value) {
            value.docs.forEach((element) {
              FirebaseFirestore.instance
                  .collection("Categories")
                  .doc('$id')
                  .collection("Article")
                  .doc(element.data()['idOfArticle'])
                  .delete();
            });
          });
        });
      });
      deleteCategoriesOfPatients(id);
      getAllCategories();
      update();
    });
  }

  Future<void> deleteCategoriesOfPatients(id) async {
    FirebaseFirestore.instance.collection("patients").get().then((value) {
      if (value.docs.isNotEmpty) {
        value.docs.forEach((elements) {
          FirebaseFirestore.instance
              .collection("patients")
              .doc(elements.data()['token'])
              .collection("myCategories")
              .where("id", isEqualTo: id)
              .get()
              .then((value) {
            print("myCategories is${value.docs.length}");
            value.docs.forEach((element) {
              FirebaseFirestore.instance
                  .collection("patients")
                  .doc(elements.data()['token'])
                  .collection("myCategories")
                  .doc(element.data()['idOfMyCategories'])
                  .delete();
            });
          });
        });
      }
    });
  }

  Future<void> deleteCollection(
      String collectionPath1, String collectionPath2) async {
    CollectionReference collectionRef = FirebaseFirestore.instance
        .collection(collectionPath1)
        .doc(tokenOfPatients)
        .collection(collectionPath2);
    QuerySnapshot querySnapshot = await collectionRef.get();
    querySnapshot.docs.forEach((doc) async {
      await doc.reference.delete();
    });
    await collectionRef.doc().delete(); // delete the collection itself
  }
}

List<MessageModel> chats = [];
