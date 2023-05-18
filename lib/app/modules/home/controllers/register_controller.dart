
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:doctor_app/app/data/doctor_account_model.dart';
import 'package:doctor_app/app/data/patients_account_model.dart';
import 'package:doctor_app/app/modules/home/controllers/create_password_controller.dart';
import 'package:doctor_app/app/modules/home/controllers/login_controller.dart';

PatientsAccountModel? patientsAccountModel;
String tokenOfDoctors='';
class RegisterController extends GetxController {



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


  void register(dynamic email, dynamic password, dynamic name, dynamic phone) {
    FirebaseAuth.instance
        .createUserWithEmailAndPassword(email: email, password: password)
        .then((value) {
      GetStorage().write('token', value.user?.uid);

      createAccount(name,email,phone,value.user?.uid,password);
    })
        .catchError((error) {
      print(error.toString());
    });
    update();

  }

  void createAccount(name, email, phone, uid,password) {
    doctorAccountModel = DoctorAccountModel(name, email, phone, uid,password,"write your bio","https://images.pexels.com/photos/220453/pexels-photo-220453.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=2","https://images.pexels.com/photos/220453/pexels-photo-220453.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=2");
    FirebaseFirestore.instance
        .collection('doctors')
        .doc(uid)
        .set(doctorAccountModel?.toMAp()??{})
        .then((value) {
      tokenOfDoctors=doctorAccountModel?.token;
          update();
      LoginController loginController = Get.put(LoginController());

      loginController.moveBetweenPages('layout');
    }).catchError((error) {
      print(error.toString());
    });
  update();
  }
}
