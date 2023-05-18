import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:doctor_app/app/data/doctor_account_model.dart';
import 'package:doctor_app/app/modules/home/controllers/create_password_controller.dart';
import 'package:doctor_app/app/modules/home/controllers/layout_controller.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:doctor_app/app/modules/home/controllers/login_controller.dart';

class UpdateProfileController extends GetxController {
  //TODO: Implement UpdateProfileController

  final count = 0.obs;
  LoginController loginController=LoginController();
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

  void updateDoctorsData({
    required String name,
    required String phone,
    required String bio,
    String? cover,
    String? image,
  }) {
    doctorAccountModel = DoctorAccountModel(
       name,
       doctorAccountModel!.email,

          phone,
      doctorAccountModel?.token,
      doctorAccountModel?.password,
      bio,

       image ?? doctorAccountModel!.image,
         cover ?? doctorAccountModel!.cover,

         );
LayoutController layoutController =LayoutController();
    FirebaseFirestore.instance
        .collection('doctors')
        .doc(doctorAccountModel!.token)
        .update(doctorAccountModel?.toMAp()??{})
        .then((value) {
index==2;
      update();
      layoutController.getDoctorsData ().then((value) {
  loginController.moveBetweenPages('layout');
  update();

});
    }).catchError((error) {
    });
    update();
  }
  File? coverImage;
  File? profileImage;
  String? valueOfImage;
  String ?valueOfCover;
  void uploadProfileImage({
    required String name,
    required String phone,
    required String bio,
  }) {
    firebase_storage.FirebaseStorage.instance
        .ref()
        .child('users/${Uri.file(profileImage!.path).pathSegments.last}')
        .putFile(profileImage!)
        .then((value) {
      value.ref.getDownloadURL().then((value) {
        print(value);
     valueOfImage=value;

        update();
      }
      ).catchError((error) {
      });
    }).catchError((error) {
    });
  }

  void uploadCoverImage({
    required String name,
    required String phone,
    required String bio,

  }) {
    firebase_storage.FirebaseStorage.instance
        .ref()
        .child('users/${Uri.file(coverImage!.path).pathSegments.last}')
        .putFile(coverImage!)
        .then((value) {
      value.ref.getDownloadURL().then((value) {
        print(value);

        update();
      }).catchError((error) {
      });
    }).catchError((error) {
    });
  }
  var picker = ImagePicker();

  Future<void> getProfileImage(name,phone,bio) async {
    final pickedFile = await picker.getImage(
      source: ImageSource.gallery,
    );

    if (pickedFile != null) {
      profileImage = File(pickedFile.path);
      uploadProfileImage(name: name, phone: phone, bio: bio);
      print(pickedFile.path);

update();
    } else {
      print('No image selected.');
    }
  }


  Future<void> getCoverImage(name,phone,bio) async {
    final pickedFile = await picker.getImage(
      source: ImageSource.gallery,
    );

    if (pickedFile != null) {
      coverImage = File(pickedFile.path);
      uploadCoverImage(name: name, phone: phone, bio: bio);
update();
    } else {
      print('No image selected.');
    }
  }
}
