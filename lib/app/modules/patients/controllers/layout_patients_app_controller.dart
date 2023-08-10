import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:doctor_app/app/data/categories_model.dart';
import 'package:doctor_app/app/data/doctor_account_model.dart';
import 'package:doctor_app/app/data/patients_account_model.dart';
import 'package:doctor_app/app/modules/home/controllers/register_controller.dart';
import 'package:doctor_app/app/modules/patients/controllers/article_controller.dart';
import 'package:doctor_app/app/modules/patients/controllers/group_chat_patients_controller.dart';
import 'package:doctor_app/app/modules/patients/views/chat_patients_view.dart';
import 'package:doctor_app/app/modules/patients/views/home_patients_view.dart';
import 'package:doctor_app/app/modules/patients/views/profile_patients_view.dart';
import 'package:doctor_app/app/modules/patients/views/subscriptions_view.dart';
import 'package:get_storage/get_storage.dart';
import 'package:path_provider/path_provider.dart';
dynamic tokenOfPatients='';
var indexPatients = 0;
bool value=false;
ArticleController articleController=ArticleController();
GroupChatPatientsController groupChatPatientsController=GroupChatPatientsController();
class LayoutPatientsAppController extends GetxController {

  List<CategoriesModel> categories = [];
  List<CategoriesModel> subsriptions = [];
  CategoriesModel? categoriesModel;
Future<void>getAllSubsriptions() async{
  if(subsriptions.isNotEmpty){
    subsriptions=[];
update();
    FirebaseFirestore.instance.collection("patients").doc(tokenOfPatients).collection("myCategories").where("like",isEqualTo: true).where("idOfPatients",isEqualTo: tokenOfPatients).get().then((value) {
      value.docs.forEach((element) {
        subsriptions.add(CategoriesModel.fromJson(element.data()));
        print("the subsriptions is${subsriptions.length}");
        update();
      });
    });

  }else{
    FirebaseFirestore.instance.collection("patients").doc(tokenOfPatients).collection("myCategories").where("like",isEqualTo: true).where("idOfPatients",isEqualTo: tokenOfPatients).get().then((value) {
      value.docs.forEach((element) {
        subsriptions.add(CategoriesModel.fromJson(element.data()));
        print("the subsriptions is${subsriptions.length}");
        update();
      });
    });

  }
}
  Future<void> getAllCategories() async {
  if(categories.isNotEmpty){
    categories=[];
    update();

    FirebaseFirestore.instance.collection("patients").doc(tokenOfPatients).collection("myCategories").get().then((value){
      value.docs.forEach((element) {
        categories.add(CategoriesModel.fromJson(element.data()));
        update();
      });
    });

  }else{
    FirebaseFirestore.instance.collection("patients").doc(tokenOfPatients).collection("myCategories").get().then((value){
      value.docs.forEach((element) {
        categories.add(CategoriesModel.fromJson(element.data()));
        update();
      });
    });
update();
  }
    update();
  }
  Future<void> updateCategories(id,index) async {
print("my id is$id");
    FirebaseFirestore.instance.collection("patients").doc(tokenOfPatients).collection("myCategories").doc(id).get().then((value){
      if(value.data()?['like']==true){
        categories[index].like=false;
        update();

        subsriptions.removeAt(index);
        update();
        FirebaseFirestore.instance.collection("patients").doc(tokenOfPatients).collection("myCategories").doc(id).update({"like":false,"idOfPatients":tokenOfPatients}).then((value) {

        });
      }
      if(value.data()?['like']==false){
        categories[index].like=true;
        update();
        FirebaseFirestore.instance.collection("patients").doc(tokenOfPatients).collection("myCategories").doc(id).update({"like":true,"idOfPatients":tokenOfPatients}).then((value) {

        });
      }
    });
    update();
  }
Locale? initLang=GetStorage().read("lang")==null?Locale("${Get.deviceLocale!.languageCode}"): Locale("${GetStorage().read("lang")}");
changeValueOfLang(){
  initLang= Locale("${GetStorage().read("lang")}");
  update();
  print("The initLang of update is${initLang}");

}
  void changeLang(String code){
    Locale locale=Locale('$code');
    GetStorage().write("lang","$code");
    update();
    Get.updateLocale(locale).then((value) {
      changeValueOfLang();
update();
    });
    update();
  }

  final count = 0.obs;
  List screenPatients=[
    HomePatientsView(),
    ChatPatientsView(),
    SubscriptionsView(),
    ProfilePatientsView(),
  ];
  List titleOfPatientsScreen=[
    'Home'.tr,
    'Chat'.tr,
    'Subscriptions'.tr,
    'Profile'.tr,
  ];
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

  Future<void> changeValueOfIndex(value) async {
    indexPatients=value;
    if(indexPatients==0){
      getAllCategories();

    }
    if(indexPatients==1){
    await  getAllAccountDoctors();

      update();

    }
    if(indexPatients==2){
      await getAllSubsriptions();

      update();
    }
    if(indexPatients==3){

     await getPatientsData();
      update();

    }
    print(indexPatients);
    update();
  }
  List <DoctorAccountModel>doctors=[];
  Future<void> getAllAccountDoctors() async {
    if(doctors.isNotEmpty){
      doctors = [];
      update();
      FirebaseFirestore.instance.collection("doctors").get().then((value) {
        value.docs.forEach((element) {
          doctors.add(DoctorAccountModel.formJson(element.data()));
          update();

          print(doctors.length);
        });
      });

    }else{
      FirebaseFirestore.instance.collection("doctors").get().then((value) {
        value.docs.forEach((element) {
          doctors.add(DoctorAccountModel.formJson(element.data()));
          update();

          print(doctors.length);
        });
      });
update();
    }
    update();
  }
  Future<void>getPatientsData()async{
    FirebaseFirestore.instance.collection("patients").doc(tokenOfPatients).get().then((value){

      patientsAccountModel=PatientsAccountModel.formJson(value.data()!);
      print("The User is${patientsAccountModel?.name.toString()}");
      update();

    });
  update();
  }
  Future<void> deleteCacheDir() async {
    final cacheDir = await getTemporaryDirectory();

    if (cacheDir.existsSync()) {
      cacheDir.deleteSync(recursive: true);
      update();

    }
    update();
  }

  /// this will delete app's storage
  Future<void> deleteAppDir() async {
    final appDir = await getApplicationSupportDirectory();

    if(appDir.existsSync()){
      appDir.deleteSync(recursive: true);
      update();

    }
    update();

  }
}
