import 'package:get/get.dart';

int kHangmanQuota = 1;

class GamePageController extends GetxController {
  var gameModel;

  void shuffle() {
    gameModel.shuffle();
    update();
  }

  void setWordRepre(String input) {
    gameModel.setWordRepre(input);
    update();
  }

  void playAgain() {
    gameModel.playAgain();
    update();
  }
}
