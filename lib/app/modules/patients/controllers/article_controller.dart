import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:doctor_app/app/data/article_model.dart';
bool valueOfHomePatients=false;
bool valueOfChatPatients=false;
bool valueOfSubscriptions=false;

class ArticleController extends GetxController {
  //TODO: Implement ArticleController

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

  ArticleModel? articleModel;
  List<ArticleModel>article=[];
  void changeValueOfHomePatients(value){
    valueOfHomePatients=value;
    print('valueOfHome is $valueOfHomePatients');
    update();
  }
  void changeValueOfSubscriptionsPatients(value){
    valueOfSubscriptions=value;
    print('valueOfHome is $valueOfHomePatients');
    update();
  }

  void getAllArticle(idOfCategories){
    if(article.isNotEmpty){
      article=[];
update();
      FirebaseFirestore.instance.collection("Categories").doc("$idOfCategories").collection("Article").get().then((value) {
        value.docs.forEach((element) {
          article.add(ArticleModel.fromJson(element.data()));
          update();
        });
      });

    }else{
      FirebaseFirestore.instance.collection("Categories").doc("$idOfCategories").collection("Article").get().then((value) {
        value.docs.forEach((element) {
          article.add(ArticleModel.fromJson(element.data()));
          update();
        });
      });

    }
  }
}
