import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:doctor_app/app/data/message_model.dart';
import 'package:doctor_app/app/modules/patients/controllers/article_controller.dart';
import 'package:doctor_app/app/modules/patients/controllers/layout_patients_app_controller.dart';

class GroupChatPatientsController extends GetxController {
  //TODO: Implement GroupChatPatientsController

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

  void changeValueOfChatPatients(value){
    valueOfChatPatients=value;
    print('valueOfHome is $valueOfChatPatients');
    update();
  }

  void sendMessage({
    required String receiverId,
    required var dateTime,
    required String text,
  }) {
    MessageModel model = MessageModel(
      text: text,
      senderId: tokenOfPatients,
      receiverId: receiverId,
      dateTime: dateTime,
      value: true,
    );

    // set my chats

    FirebaseFirestore.instance
        .collection('patients')
        .doc("$tokenOfPatients")
        .collection('doctors')
        .doc("$receiverId")
        .collection('messages')
        .add(model.toMap())
        .then((value) {
      getMessages(receiverId: receiverId);
      update();
    }).catchError((error) {
    });

    // set receiver chats

    FirebaseFirestore.instance
        .collection('doctors')
        .doc("$receiverId")
        .collection('patients')
        .doc("$tokenOfPatients")
        .collection('messages')
        .add(model.toMap())
        .then((value) {
          getMessages(receiverId: receiverId);
          update();
    }).catchError((error) {
    });
  }

  List<MessageModel> messages = [];

  void getMessages({
    required String receiverId,
  }) {

    FirebaseFirestore.instance
        .collection('patients')
        .doc(tokenOfPatients).collection("doctors").doc("$receiverId")
        .collection('messages')
        .orderBy('dateTime')
        .snapshots()
        .listen((event) {
      messages = [];

      event.docs.forEach((element) {
        messages.add(MessageModel.fromJson(element.data()));
        update();
      });

    });
  update();
  }
}
