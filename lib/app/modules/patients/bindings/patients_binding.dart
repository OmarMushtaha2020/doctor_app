import 'package:get/get.dart';

import 'package:doctor_app/app/modules/patients/controllers/article_controller.dart';
import 'package:doctor_app/app/modules/patients/controllers/create_password_patients_controller.dart';
import 'package:doctor_app/app/modules/patients/controllers/forgot_password_patients_controller.dart';
import 'package:doctor_app/app/modules/patients/controllers/group_chat_patients_controller.dart';
import 'package:doctor_app/app/modules/patients/controllers/layout_patients_app_controller.dart';
import 'package:doctor_app/app/modules/patients/controllers/register_patients_controller.dart';
import 'package:doctor_app/app/modules/patients/controllers/search_controller.dart';
import 'package:doctor_app/app/modules/patients/controllers/update_profile_patients_controller.dart';
import 'package:doctor_app/app/modules/patients/views/article_details_patients_view.dart';

import '../controllers/patients_controller.dart';

class PatientsBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<SearchController>(
      () => SearchController(),
    );

    Get.lazyPut<ArticleController>(
      () => ArticleController(),
    );
    Get.lazyPut<GroupChatPatientsController>(
      () => GroupChatPatientsController(),
    );
    Get.lazyPut<CreatePasswordPatientsController>(
      () => CreatePasswordPatientsController(),
    );
    Get.lazyPut<UpdateProfilePatientsController>(
      () => UpdateProfilePatientsController(),
    );
    Get.lazyPut<LayoutPatientsAppController>(
      () => LayoutPatientsAppController(),
    );
    Get.lazyPut<ForgotPasswordPatientsController>(
      () => ForgotPasswordPatientsController(),
    );
    Get.lazyPut<RegisterPatientsController>(
      () => RegisterPatientsController(),
    );
    Get.lazyPut<PatientsController>(
      () => PatientsController(),
    );
    Get
      ..lazyPut<ArticleDetailsPatientsView>(
        () => ArticleDetailsPatientsView(),
      );
  }
}
