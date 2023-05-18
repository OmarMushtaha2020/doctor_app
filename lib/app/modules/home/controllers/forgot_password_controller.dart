import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:doctor_app/app/data/doctor_account_model.dart';
import 'package:doctor_app/app/modules/home/controllers/create_password_controller.dart';
import 'package:doctor_app/app/modules/home/controllers/login_controller.dart';

class ForgotPasswordController extends GetxController {
  //TODO: Implement ForgotPasswordController

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


  LoginController loginController=LoginController();
  void checkIsEmailInDoctorsCollection(dynamic email) {
    FirebaseFirestore.instance
        .collection('doctors')
        .where('email', isEqualTo: email).get().then((value) {
      if (value.docs.length != 0) {
        value.docs.forEach((element) {
          doctorAccountModel=DoctorAccountModel.formJson(element.data());
          print(doctorAccountModel?.token);
        });

        loginController.moveBetweenPages('CreatePasswordView',arguments: doctorAccountModel!.token);

      } else {
        print("The email isn't in doctors ");
      }
    }
    );
    update();
  }}
