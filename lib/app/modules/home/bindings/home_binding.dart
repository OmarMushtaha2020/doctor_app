import 'package:get/get.dart';

import 'package:doctor_app/app/modules/home/controllers/add_article_controller.dart';
import 'package:doctor_app/app/modules/home/controllers/article_details_controller.dart';
import 'package:doctor_app/app/modules/home/controllers/create_password_controller.dart';
import 'package:doctor_app/app/modules/home/controllers/forgot_password_controller.dart';
import 'package:doctor_app/app/modules/home/controllers/group_chat_controller.dart';
import 'package:doctor_app/app/modules/home/controllers/layout_controller.dart';
import 'package:doctor_app/app/modules/home/controllers/login_controller.dart';
import 'package:doctor_app/app/modules/home/controllers/page_selection_doctor_or_patient_controller.dart';
import 'package:doctor_app/app/modules/home/controllers/register_controller.dart';
import 'package:doctor_app/app/modules/home/controllers/update_article_controller.dart';
import 'package:doctor_app/app/modules/home/controllers/update_profile_controller.dart';

class HomeBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<UpdateArticleController>(
      () => UpdateArticleController(),
    );
    Get.lazyPut<ArticleDetailsController>(
      () => ArticleDetailsController(),
    );
    Get.lazyPut<AddArticleController>(
      () => AddArticleController(),
    );
    Get.lazyPut<GroupChatController>(
      () => GroupChatController(),
    );
    Get.lazyPut<UpdateProfileController>(
      () => UpdateProfileController(),
    );
    Get.lazyPut<CreatePasswordController>(
      () => CreatePasswordController(),
    );
    Get.lazyPut<ForgotPasswordController>(
      () => ForgotPasswordController(),
    );

    Get.lazyPut<RegisterController>(
      () => RegisterController(),
    );
    Get.lazyPut<LoginController>(
      () => LoginController(),
    );
    Get.lazyPut<LayoutController>(
      () => LayoutController(),
    );
    Get.lazyPut<PageSelectionDoctorOrPatientController>(
      () => PageSelectionDoctorOrPatientController(),
    );
  }
}
