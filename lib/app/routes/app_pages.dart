import 'package:hangman_rebuild/app/modules/game/gamePage_view.dart';
import 'package:hangman_rebuild/app/modules/game/gamePage_binding.dart';
import 'package:get/get.dart';
import 'package:hangman_rebuild/app/modules/home/homePage_binding.dart';
import 'package:hangman_rebuild/app/modules/home/homePage_view.dart';
part 'app_routes.dart';

class AppPages {
  static const INITIAL = Routes.HOME_ROUTE;

  static final pages = [
    GetPage(
        name: Routes.HOME_ROUTE,
        page: () => HomePageView(),
        binding: HomePageBinding()),
    GetPage(
      name: Routes.GAME_ROUTE,
      page: () => GamePageView(),
      binding: GamePageBinding(),
    ),
  ];
}
