import 'package:get/get.dart';
import 'package:hangman_rebuild/app/modules/game/gamePage_controller.dart';

class GamePageBinding extends Bindings {
  @override
  void dependencies() {
    Get.put<GamePageController>(
      GamePageController(),
    );
    Get.lazyPut<MyTextController>(() => MyTextController());
  }
}
