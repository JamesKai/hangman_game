import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hangman_rebuild/app/modules/game/gamePage_model.dart';

int kHangmanQuota = 1;

class GamePageController extends GetxController {
  GameModel gameModel;

  @override
  onInit() {
    print('controller is open');
    gameModel = GameModel();
    print('Model initialized');
    super.onInit();
  }

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

  @override
  void onClose() {
    print('controller is closed');
    super.onClose();
  }
}

class MyTextController extends TextEditingController {}
