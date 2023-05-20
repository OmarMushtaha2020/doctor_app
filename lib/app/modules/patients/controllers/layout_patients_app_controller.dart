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
dynamic tokenOfPatients='';
var indexPatients = 0;
bool value=false;
ArticleController articleController=ArticleController();
GroupChatPatientsController groupChatPatientsController=GroupChatPatientsController();
class LayoutPatientsAppController extends GetxController {
  List<CategoriesModel> categories = [];
  List<CategoriesModel> subsriptions = [];
  CategoriesModel? categoriesModel;
// Future<void>  addCategoriesToPatients() async {
//     FirebaseFirestore.instance.collection("Categories").get().then((values) {
//       update();
//
//       values.docs.forEach((element) {
//         update();
//
//         FirebaseFirestore.instance.collection("patients").doc(tokenOfPatients).collection("myCategories").get().then((value) {
//    if(value.docs.isEmpty){
//      print("No");
//      update();
//
//      FirebaseFirestore.instance.collection("Categories").get().then((value) {
//        print(value.docs.length);
//          print("!");
//           categoriesModel=CategoriesModel(element.data()['nameCategories'],element.data()['detailsCategories'], element.data()['imageCategories'], element.data()['like'],id:element.data()['id']);
//        update();
//
//        FirebaseFirestore.instance
//              .collection('patients')
//              .doc(tokenOfPatients).collection("myCategories").add(categoriesModel?.toMap()??{}).then((value) {
//            update();
//
//            FirebaseFirestore.instance
//                .collection('patients')
//                .doc(tokenOfPatients).collection("myCategories").doc(value.id).update({"idOfMyCategories":value.id}).then((value) {
//                  update();
//            });
//          });
//
//      });
//
//    }else{
//      print("yes");
//      deleteCollection('patients','myCategories').then((value) {
//        update();
//
//        categoriesModel=CategoriesModel(element.data()['nameCategories'],element.data()['detailsCategories'], element.data()['imageCategories'], element.data()['like'],id:element.data()['id']);
// update();
//        FirebaseFirestore.instance
//           .collection('patients')
//           .doc(tokenOfPatients).collection("myCategories").add(categoriesModel?.toMap()??{}).then((value) {
//          update();
//
//          FirebaseFirestore.instance
//              .collection('patients')
//              .doc(tokenOfPatients).collection("myCategories").doc(value.id).update({"idOfMyCategories":value.id}).then((value) {
//                update();
//          });
//        });
//      });
// //      FirebaseFirestore.instance.collection("patients").doc(tokenOfPatients).collection("myCategories").get().then((value) {
// // value.docs.forEach((element) {
// // element.reference.delete();
// //
// // });
// // if(value.docs.isEmpty){
// //   FirebaseFirestore.instance.collection("Categories").get().then((value) {
// //     value.docs.forEach((element) {
// //       FirebaseFirestore.instance
// //           .collection('patients')
// //           .doc(tokenOfPatients).collection("myCategories").add(element.data()).then((value) {
// //         // getAllCategories();
// //       });
// //     });
// //
// //   });
// //
// //
// // }
//
//
//      // });
//    }
//  });
//
//
//
//       });
//
//     });
// update();
//   }
  // Future<void> deleteCollection(String collectionPath1,String collectionPath2) async {
  //   CollectionReference collectionRef = FirebaseFirestore.instance.collection(collectionPath1).doc(tokenOfPatients).collection(collectionPath2);
  //   QuerySnapshot querySnapshot = await collectionRef.get();
  //   querySnapshot.docs.forEach((doc) async {
  //     await doc.reference.delete();
  //   });
  //   await collectionRef.doc().delete(); // delete the collection itself
  // }
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

  }
    // update();
  }
  Future<void> updateCategories(id) async {
print("my id is$id");
    FirebaseFirestore.instance.collection("patients").doc(tokenOfPatients).collection("myCategories").doc(id).get().then((value){
      if(value.data()?['like']==true){
        FirebaseFirestore.instance.collection("patients").doc(tokenOfPatients).collection("myCategories").doc(id).update({"like":false,"idOfPatients":tokenOfPatients}).then((value) {
          getAllSubsriptions();
          getAllCategories();

        });
      }
      if(value.data()?['like']==false){
        FirebaseFirestore.instance.collection("patients").doc(tokenOfPatients).collection("myCategories").doc(id).update({"like":true,"idOfPatients":tokenOfPatients}).then((value) {
          getAllSubsriptions();
          getAllCategories();
        });
      }
    });
    update();
  }
Locale? initLang=GetStorage().read("lang")==null?Get.deviceLocale: Locale(GetStorage().read("lang"));
  void changeLang(String code){
    Locale locale=Locale('$code');
    GetStorage().write("lang", code);
    Get.updateLocale(locale);
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
      // articleController.changeValueOfHomePatients(false);
      // articleController.changeValueOfSubscriptionsPatients(false);
      //
      // groupChatPatientsController.changeValueOfChatPatients(false);
    }
    if(indexPatients==1){
    await  getAllAccountDoctors();
    // articleController.changeValueOfHomePatients(false);
    // articleController.changeValueOfSubscriptionsPatients(false);
    //
    // groupChatPatientsController.changeValueOfChatPatients(false);
      update();

    }
    if(indexPatients==2){
      await getAllSubsriptions();
      // articleController.changeValueOfSubscriptionsPatients(false);
      //
      // articleController.changeValueOfHomePatients(false);
      // groupChatPatientsController.changeValueOfChatPatients(false);
      update();
    }
    if(indexPatients==3){

     await getPatientsData();
     // articleController.changeValueOfHomePatients(false);
     // articleController.changeValueOfSubscriptionsPatients(false);
     //
     // groupChatPatientsController.changeValueOfChatPatients(false);
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
}
