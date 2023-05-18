import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:doctor_app/app/data/doctor_account_model.dart';
import 'package:doctor_app/app/modules/home/controllers/login_controller.dart';
DoctorAccountModel? doctorAccountModel;
class CreatePasswordController extends GetxController {
  //TODO: Implement CreatePasswordController

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
  void upatePasswordOfAccountDoctors(dynamic token,dynamic password,dynamic confirm_password){
    if(password==confirm_password){
      FirebaseFirestore.instance.collection("doctors").doc(token).update({"password":password}).then((value) {
        loginController.moveBetweenPages('login');

      });
      update();

    }
  }

}
