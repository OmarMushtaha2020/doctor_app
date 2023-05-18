import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:doctor_app/app/data/categories_model.dart';
import 'package:doctor_app/app/modules/patients/controllers/layout_patients_app_controller.dart';

class SearchController extends GetxController {
  //TODO: Implement SearchController
  List<CategoriesModel> searchCategories = [];
LayoutPatientsAppController layoutPatientsAppController=LayoutPatientsAppController();
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

Future<void> getAllSearchCategory(nameCategories) async {
  searchCategories=[];
  FirebaseFirestore.instance.collection("patients").doc(tokenOfPatients).collection("myCategories").where("nameCategories",isEqualTo: nameCategories).get().then((value){
    value.docs.forEach((element) {
      searchCategories.add(CategoriesModel.fromJson(element.data()));
      update();
    });
  });
update();
}
  Future<void> updateCategories(id,name) async {
    print("my id is$id");
    FirebaseFirestore.instance.collection("patients").doc(tokenOfPatients).collection("myCategories").doc(id).get().then((value){
      if(value.data()?['like']==true){
        FirebaseFirestore.instance.collection("patients").doc(tokenOfPatients).collection("myCategories").doc(id).update({"like":false,"idOfPatients":tokenOfPatients}).then((value) {
          layoutPatientsAppController.getAllSubsriptions();
          getAllSearchCategory(name);
          layoutPatientsAppController.getAllCategories();

        });
      }
      if(value.data()?['like']==false){
        FirebaseFirestore.instance.collection("patients").doc(tokenOfPatients).collection("myCategories").doc(id).update({"like":true,"idOfPatients":tokenOfPatients}).then((value) {
          layoutPatientsAppController.getAllSubsriptions();
          layoutPatientsAppController.getAllCategories();
          getAllSearchCategory(name);

        });
      }
    });
    update();
  }

}
