
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:doctor_app/app/data/patients_account_model.dart';
import 'package:doctor_app/app/modules/home/controllers/login_controller.dart';
import 'package:doctor_app/app/modules/home/controllers/register_controller.dart';
import 'package:doctor_app/app/modules/patients/controllers/layout_patients_app_controller.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;

class UpdateProfilePatientsController extends GetxController {
  //TODO: Implement UpdateProfileController

  final count = 0.obs;
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
  LoginController loginController =LoginController();
  Future<void> updatePatientsData({
    required String name,
    required String phone,
    required String bio,
    String? cover,
    String? image,
  }) async {
    patientsAccountModel = PatientsAccountModel(
      name,
      patientsAccountModel!.email,

      phone,
      patientsAccountModel?.token,
      patientsAccountModel?.password,
      bio,

      image ?? patientsAccountModel!.image,
      cover ?? patientsAccountModel!.cover,

    );
    LayoutPatientsAppController layoutController =LayoutPatientsAppController();
    FirebaseFirestore.instance
        .collection('patients')
        .doc(patientsAccountModel!.token)
        .update(patientsAccountModel?.toMAp()??{})
        .then((value) {
update();
    }).catchError((error) {
    });
    update();
  }
  File? coverImage;
  File? profileImage;
  void uploadProfileImage({
    required String name,
    required String phone,
    required String bio,
  }) {
    firebase_storage.FirebaseStorage.instance
        .ref()
        .child('patients/${Uri.file(profileImage!.path).pathSegments.last}')
        .putFile(profileImage!)
        .then((value) {
      value.ref.getDownloadURL().then((value) {
        print(value);
        updatePatientsData(
          name: name,
          phone: phone,
          bio: bio,
          image: value,
        );
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
        .child('patients/${Uri.file(coverImage!.path).pathSegments.last}')
        .putFile(coverImage!)
        .then((value) {
      value.ref.getDownloadURL().then((value) {
        print(value);
        updatePatientsData(
          name: name,
          phone: phone,
          bio: bio,
          cover: value,
        );

        update();
      }).catchError((error) {
      });
    }).catchError((error) {
    });
  }
  var picker = ImagePicker();

  Future<void> getProfileImage(name,phone,bio) async {
    final pickedFile = await picker.pickImage(
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
    final pickedFile = await picker.pickImage(
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
