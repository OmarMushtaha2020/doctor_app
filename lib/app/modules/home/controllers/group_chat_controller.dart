import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:doctor_app/app/data/message_model.dart';
import 'package:doctor_app/app/modules/home/controllers/layout_controller.dart';
import 'package:doctor_app/app/modules/home/controllers/login_controller.dart';
import 'package:doctor_app/app/modules/home/controllers/register_controller.dart';
bool valueOfChat=false;

class GroupChatController extends GetxController {
  //TODO: Implement GroupChatController
  LoginController loginController=LoginController();

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
  Future<void> changeValueOfChat(value) async {
    valueOfChat=value;
    print('valueOfHome is $valueOfChat');
    update();
  }
  void sendMessage({
    required String receiverId,
    required var dateTime,
    required String text,
  }) {
    MessageModel model = MessageModel(
      text: text,
      senderId: tokenOfDoctors,
      receiverId: receiverId,
      dateTime: dateTime,
      value: false,
    );

    // set my chats

    FirebaseFirestore.instance
        .collection('patients')
        .doc("$receiverId")
        .collection('doctors')
        .doc("$tokenOfDoctors")
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
        .doc("$tokenOfDoctors")
        .collection('patients')
        .doc("$receiverId")
        .collection('messages')
        .add(model.toMap())
        .then((value) {
          getMessages(receiverId: receiverId);
          update();

    }).catchError((error) {
    });
    update();
  }

  List<MessageModel> messages = [];
LayoutController layoutController=LayoutController();
  void getMessages({
    required String receiverId,
  }) {

    FirebaseFirestore.instance
        .collection('doctors')
        .doc(tokenOfDoctors)
        .collection('patients')
        .doc("$receiverId")
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
  Future<void> changeValueOfIndex(values) async {
changeValueOfChat(true).then((value) {
  index=values;
  loginController.moveBetweenPages('layout');
  update();

});



    update();
}
}
