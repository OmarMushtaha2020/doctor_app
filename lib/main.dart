import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:doctor_app/app/data/on_message_notification_model.dart';
import 'package:doctor_app/app/modules/home/controllers/layout_controller.dart';
import 'package:doctor_app/shared/locale/locale.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:doctor_app/firebase_options.dart';

import 'app/modules/home/controllers/page_selection_doctor_or_patient_controller.dart';
import 'app/modules/home/controllers/register_controller.dart';
import 'app/modules/patients/controllers/layout_patients_app_controller.dart';
import 'app/routes/app_pages.dart';
import 'shared/components/my_encryption_decryption.dart';

bool? tokenValueDoctor;
bool? tokenValuePatients;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  NotificationSettings settings = await FirebaseMessaging.instance.requestPermission(
    alert: true,
    badge: true,
    sound: true,
  );
  FirebaseMessaging.onBackgroundMessage(backgroundHandler);
  FirebaseMessaging.onMessageOpenedApp.listen((event) {
    if(event.data.containsKey("route")){
      Get.offNamed("layout");
    }
  });
  await GetStorage.init();

  valueOfSelection = GetStorage().read("valueOfSelection");


  if (valueOfSelection == false) {
    tokenOfDoctors = GetStorage().read("token");
    print("the tokenOfDoctors is$tokenOfDoctors ");
    if (tokenOfDoctors != null) {
      tokenValueDoctor = true;
      print(tokenOfDoctors);
    } else {
      tokenValueDoctor = false;
    }
  }
  if (valueOfSelection == true) {
    tokenOfPatients = GetStorage().read("tokenOfPatients");
    if (tokenOfPatients != null) {
      tokenValuePatients = true;
      print(tokenOfDoctors);

    } else {
      tokenValuePatients = false;
    }
  }

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) {
        Get.lazyPut<LayoutPatientsAppController>(() => LayoutPatientsAppController());

        LayoutPatientsAppController layoutPatientsAppController =
            Get.find<LayoutPatientsAppController>();

        print("The lang is ${layoutPatientsAppController.initLang}");
        // layoutPatientsAppController.deleteAppDir();
        // layoutPatientsAppController.deleteCacheDir();


        return GetMaterialApp(

          title: "Application",
          locale: layoutPatientsAppController.initLang,
          translations: MyLocale(),

          debugShowCheckedModeBanner: false,
          theme: ThemeData(
            scaffoldBackgroundColor: const Color(0Xffffffff),
            appBarTheme:  const AppBarTheme(
              systemOverlayStyle: SystemUiOverlayStyle(
                statusBarColor: Colors.transparent,
statusBarBrightness: Brightness.dark,
statusBarIconBrightness: Brightness.dark,
              ),
                backgroundColor: Colors.white, elevation: 0),
          ),
          initialRoute: AppPages.INITIAL,
          themeMode: ThemeMode.light,
          getPages: AppPages.routes,
        );
      },
    );
  }

}
