import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:doctor_app/app/modules/home/controllers/login_controller.dart';
bool? valueOfSelection;

class PageSelectionDoctorOrPatientController extends GetxController {

  final count = 0.obs;
  LoginController loginController=LoginController();
bool value=false;
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
  void changeValue(value){
    valueOfSelection=value;
    print(valueOfSelection);
    if(valueOfSelection==false){
      GetStorage().write("valueOfSelection", false);
      Future.delayed(Duration(milliseconds: 500)).then((value){
        loginController.moveBetweenPages('login');
      });
    }else{
      GetStorage().write("valueOfSelection", true);

      Future.delayed(Duration(milliseconds: 500)).then((value) {
        loginController.moveBetweenPages('patients');
      });
    }
    update();
  }


}
