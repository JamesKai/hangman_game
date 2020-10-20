import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hangman_rebuild/app/modules/game/gamePage_model.dart';
import 'package:hive/hive.dart';

int kHangmanQuota = 1;

class GamePageController extends GetxController {
  GameModel gameModel;
  TextEditingController textController;
  // List<String> myGameResults = [];
  Box<String> resultBox;

  @override
  onInit() {
    print('GamePageController is open');
    gameModel = GameModel();
    print('Model initialized');
    textController = TextEditingController();
    print('TextEditingController initialized');
    resultBox = Hive.box('resultBox');
    super.onInit();
  }

  @override
  void onClose() {
    textController.dispose();
    print('TextEditingController is disposed');
    print('GamePageController is closed');
    super.onClose();
  }
}

extension MyGameController on GamePageController {
  void shuffle() {
    gameModel.shuffle();
    addResult(gameModel.word);
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

  void clearUp() {
    gameModel.resetState();
    update();
  }
}

extension MyGameResultController on GamePageController {
  void addResult(String result) {
    // myGameResults.add(result);
    resultBox.add(result);

    // update();
  }
}
