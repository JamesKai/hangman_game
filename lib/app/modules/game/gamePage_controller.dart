import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hangman_rebuild/app/modules/game/gamePage_model.dart';

int kHangmanQuota = 1;

class GamePageController extends GetxController {
  GameModel gameModel;
  TextEditingController textController;

  @override
  onInit() {
    print('GamePageController is open');
    gameModel = GameModel();
    print('Model initialized');
    textController = TextEditingController();
    print('TextEditingController initialized');
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

extension MyTextEditingController on GamePageController {}
