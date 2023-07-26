import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:doctor_app/app/modules/patients/controllers/layout_patients_app_controller.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:doctor_app/app/modules/home/controllers/register_controller.dart';

class LoginController extends GetxController {
  //TODO: Implement HomeController

  final count = 0.obs;
bool loginValue=false;
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
changeValueOfLogin(bool values){
    loginValue=values;
    print(loginValue);
    update();
}
  void increment() => count.value++;

  Future<void> moveBetweenPages(route, {arguments}) async {
    Get.offNamed(route, arguments: arguments);
  }

  void login(dynamic email, dynamic password) {
    changeValueOfLogin(true);

    checkIsEmailInDoctorsCollection(email, password);

    update();
  }

  void checkIsEmailInDoctorsCollection(dynamic email, dynamic password) {
    FirebaseFirestore.instance
        .collection('doctors')
        .where('email', isEqualTo: email)
        .get()
        .then((value) {
      if (value.docs.length != 0) {

        FirebaseAuth.instance
            .signInWithEmailAndPassword(email: email, password: password)
            .then((value) {
          GetStorage().write('token', value.user?.uid);

          tokenOfDoctors = value.user!.uid;
          update();

          moveBetweenPages('layout').then((value) {
            changeValueOfLogin(false);

          });
        }).catchError((error) {
          changeValueOfLogin(false);

          print(error.toString());
        });
      } else {
        changeValueOfLogin(false);

        print("The email isn't in doctors ");
      }
    });
    update();
  }
}
