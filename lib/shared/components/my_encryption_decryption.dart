import 'package:doctor_app/app/data/on_message_notification_model.dart';
import 'package:encrypt/encrypt.dart' as encrypt;
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:get/get.dart';

class MyEncryptionDecryption {
  //For AES Encryption/Decryption
  static final key = encrypt.Key.fromLength(32);
  static final iv = encrypt.IV.fromLength(16);
  static final encrypter = encrypt.Encrypter(encrypt.AES(key));

  static encryptAES(text) {
    final encrypted = encrypter.encrypt(text, iv: iv);

    print(encrypted.bytes);
    print(encrypted.base16);
    print(encrypted.base64);
    return encrypted;
  }

  static decryptAES(text) {
    final decrypted = encrypter.decrypt64(text, iv: iv);
    print(decrypted);
    return decrypted;
  }
}
Future<void> backgroundHandler(RemoteMessage message) async {
  print("Handling a background message: ${message.messageId}");
  if(message.data.containsKey("route")){
    Get.offNamed("layout");
  }
}