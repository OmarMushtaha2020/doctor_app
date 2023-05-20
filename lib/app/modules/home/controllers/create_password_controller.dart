import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:doctor_app/shared/components/my_encryption_decryption.dart';
import 'package:firebase_auth/firebase_auth.dart';
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
  Future<void> upatePasswordOfAccountDoctors(dynamic token,dynamic password,dynamic confirm_password) async {

    if(password==confirm_password){
      FirebaseAuth.instance.currentUser!.updatePassword(password).then((value)async {
        var text= await MyEncryptionDecryption.encryptAES("$password");
        print(" the ex is${text.base64}");
        FirebaseFirestore.instance.collection("doctors").doc(token).update({"password":text.base64}).then((value) {
          FirebaseAuth.instance.signOut().then((value) {
            loginController.moveBetweenPages('login');

          });

        });
        update();

      });
      update();

    }
  }

}
