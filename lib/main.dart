import 'package:device_preview/device_preview.dart';
import 'package:doctor_app/shared/locale/locale.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:doctor_app/firebase_options.dart';

import 'app/modules/home/controllers/page_selection_doctor_or_patient_controller.dart';
import 'app/modules/home/controllers/register_controller.dart';
import 'app/modules/patients/controllers/layout_patients_app_controller.dart';
import 'app/routes/app_pages.dart';

bool? tokenValueDoctor;
bool? tokenValuePatients;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

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
      // valueOfSelection=null;
    }
  }
  if (valueOfSelection == true) {
    tokenOfPatients = GetStorage().read("tokenOfPatients");
    if (tokenOfPatients != null) {
      tokenValuePatients = true;
      print(tokenOfDoctors);
      //  var layoutPatientsAppController=Get.lazyPut(() => LayoutPatientsAppController());
      // var categories= Get.find<LayoutPatientsAppController>();
      //  categories.getAllCategories();
    } else {
      tokenValuePatients = false;
      // valueOfSelection=null;
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
        Get.lazyPut<LayoutPatientsAppController>(
          () => LayoutPatientsAppController(),
        );

        LayoutPatientsAppController layoutPatientsAppController =
            Get.find<LayoutPatientsAppController>();
        print("The lang is ${layoutPatientsAppController.initLang}");
        return DevicePreview(
          builder: (context) => GetMaterialApp(
            title: "Application",
            locale: layoutPatientsAppController.initLang,
            translations: MyLocale(),
            debugShowCheckedModeBanner: false,
            theme: ThemeData(
              scaffoldBackgroundColor: Color(0Xffffffff),
              appBarTheme: const AppBarTheme(
                  backgroundColor: Colors.white, elevation: 0),
            ),
            initialRoute: AppPages.INITIAL,
            getPages: AppPages.routes,
          ),
        );
      },
    );
  }
}
