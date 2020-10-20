import 'package:get/get.dart';

import 'package:hangman_rebuild/app/modules/result_page/result_page_controller.dart';

class ResultPageBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ResultPageController>(
      () => ResultPageController(),
    );
  }
}
