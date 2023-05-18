import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:doctor_app/app/data/patients_account_model.dart';
import 'package:doctor_app/app/modules/home/controllers/login_controller.dart';

class ForgotPasswordPatientsController extends GetxController {
  //TODO: Implement ForgotPasswordPatientsController

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
  PatientsAccountModel? patientsAccountModel;

  LoginController loginController=LoginController();
  void checkIsEmailInPatientsCollection(dynamic email) {
    FirebaseFirestore.instance
        .collection('patients')
        .where('email', isEqualTo: email).get().then((value) {
      if (value.docs.length != 0) {
        value.docs.forEach((element) {
          patientsAccountModel=PatientsAccountModel.formJson(element.data());
          print(patientsAccountModel?.token);
        });

      loginController.moveBetweenPages('CreatePasswordPatients',arguments: patientsAccountModel!.token);

      } else {
        print("The email isn't in doctors ");
      }
    }
    );
    update();
  }

}
