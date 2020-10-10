import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:get/get.dart';
import 'package:hangman_rebuild/app/modules/game/game_model.dart';

int kHangmanQuota = 1;

class GamePageController extends GetxController {
  GameModel gameModel;

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

class MyTextController extends TextEditingController {}
