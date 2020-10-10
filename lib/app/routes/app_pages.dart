import 'package:hangman_rebuild/app/modules/home/gamePage_view.dart';
import 'package:hangman_rebuild/app/modules/home/gamePage_binding.dart';
import 'package:get/get.dart';
part 'app_routes.dart';

class AppPages {
  static const INITIAL = Routes.HOME;

  static final pages = [
    GetPage(
      name: INITIAL,
      page: () => GamePageView(),
      binding: GamePageBinding(),
    ),
  ];
}
