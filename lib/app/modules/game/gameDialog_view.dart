import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hangman_rebuild/app/modules/game/gamePage_controller.dart';

class GameDialogView {
  // remember to specify the controller type for the Get.find<[Type]> if there's
  // multiple controller in the bindings
  // static GamePageController controller = Get.find<GamePageController>();
  static void showLoseDialog(BuildContext context, FocusNode node) {
    showDialog(
      context: context,
      builder: (context) => CupertinoAlertDialog(
        title: Text(
          '😢 You Lose',
          style: TextStyle(color: Colors.white),
        ),
        content: LoseInfo(
          withAns: false,
        ),
        actions: [
          TextButton(
            child: Text(
              'Try Again',
              style: TextStyle(color: Colors.white),
            ),
            onPressed: () {
              Get.find<GamePageController>().playAgain();
              Get.back();
              node.requestFocus();
            },
          ),
          TextButton(
            child: Text(
              'Reveal Answer',
              style: TextStyle(color: Colors.white),
            ),
            onPressed: () {
              Get.back();
              GameDialogView.showLoseDialogWithAns(context, node);
              node.unfocus();
            },
          ),
          TextButton(
            child: Text(
              'Close',
              style: TextStyle(color: Colors.white),
            ),
            onPressed: () {
              Get.find<GamePageController>().shuffle();
              Get.back();
              node.unfocus();
            },
          ),
        ],
      ),
    );
  }

  static void showLoseDialogWithAns(BuildContext context, FocusNode node) {
    showDialog(
      context: context,
      builder: (context) => CupertinoAlertDialog(
        title: Text('😢 You Lose'),
        content: LoseInfo(
          withAns: true,
        ),
        actions: [
          TextButton(
            child: Text(
              'Close',
              style: TextStyle(color: Colors.white),
            ),
            onPressed: () {
              Get.find<GamePageController>().shuffle();
              Get.close(1);
              node.unfocus();
            },
          ),
        ],
      ),
    );
  }

  static void showWinDialog(BuildContext context, FocusNode node) {
    showDialog(
      context: context,
      builder: (_) => CupertinoAlertDialog(
        title: Text('😃 You Win!'),
        content: WinInfo(),
        actions: <Widget>[
          TextButton(
            child: Text(
              'Close!',
              style: TextStyle(color: Colors.white),
            ),
            onPressed: () {
              Get.back();
              Get.find<GamePageController>().shuffle();
              node.unfocus();
            },
          )
        ],
      ),
    );
  }
}

class WinInfo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Text(
      'Congrats, you are superb!',
      style: TextStyle(
          color: Colors.orangeAccent,
          fontSize: 20,
          height: 1.5,
          fontWeight: FontWeight.bold),
    );
  }
}

class LoseInfo extends StatelessWidget {
  final bool withAns;
  const LoseInfo({
    this.withAns,
  });
  @override
  Widget build(BuildContext context) {
    if (!withAns) {
      return Text(
        'Sorry, you did not win the game. \n  ',
        style: TextStyle(
            color: Colors.orangeAccent,
            fontSize: 20,
            height: 1.5,
            fontWeight: FontWeight.bold),
      );
    } else {
      var c = Get.find<GamePageController>();
      return Text(
        'Sorry, you did not win the game. \nAnswer: ${c.gameModel.word}',
        style: TextStyle(
            color: Colors.orangeAccent,
            fontSize: 20,
            height: 1.5,
            fontWeight: FontWeight.bold),
      );
    }
  }
}
