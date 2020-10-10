import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hangman_rebuild/app/modules/home/gamePage_controller.dart';

class GameDialogView {
  static GamePageController controller = Get.find();
  static void showLoseDialog(BuildContext context, FocusNode node) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(
          '😢 You Lose',
          style: TextStyle(color: Colors.white),
        ),
        content: LoseInfo(
          hangmanControl: GameDialogView.controller,
          withAns: false,
        ),
        actions: [
          TextButton(
            child: Text(
              'Try Again',
              style: TextStyle(color: Colors.white),
            ),
            onPressed: () {
              Get.back();
              GameDialogView.controller.playAgain();
              node.requestFocus();
            },
          ),
          TextButton(
            child: Text(
              'Reveal Answer',
              style: TextStyle(color: Colors.white),
            ),
            onPressed: () {
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
              node.unfocus();
              Get.back();
              GameDialogView.controller.shuffle();
            },
          ),
        ],
      ),
    );
  }

  static void showLoseDialogWithAns(BuildContext context, FocusNode node) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('😢 You Lose'),
        content: LoseInfo(
          hangmanControl: GameDialogView.controller,
          withAns: true,
        ),
        actions: [
          TextButton(
            child: Text(
              'Close',
              style: TextStyle(color: Colors.white),
            ),
            onPressed: () {
              Get.close(2);
              GameDialogView.controller.shuffle();
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
        builder: (_) => AlertDialog(
              title: Text('😃 You Win!'),
              content: WinInfo(
                hangmanControl: GameDialogView.controller,
              ),
              actions: <Widget>[
                TextButton(
                  child: Text(
                    'Close!',
                    style: TextStyle(color: Colors.white),
                  ),
                  onPressed: () {
                    Get.back();
                    GameDialogView.controller.shuffle();
                    node.unfocus();
                  },
                )
              ],
            ));
  }
}

class PlayInfo extends StatelessWidget {
  const PlayInfo({
    Key key,
    @required this.hangmanControl,
  }) : super(key: key);

  final GamePageController hangmanControl;

  @override
  Widget build(BuildContext context) {
    return Text(hangmanControl.gameModel.displayNote);
  }
}

class WinInfo extends StatelessWidget {
  final GamePageController hangmanControl;

  const WinInfo({
    Key key,
    @required this.hangmanControl,
  }) : super(key: key);
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
  final GamePageController hangmanControl;
  final bool withAns;
  const LoseInfo({
    Key key,
    this.withAns,
    @required this.hangmanControl,
  }) : super(key: key);
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
      return Text(
        'Sorry, you did not win the game. \nAnswer: ${hangmanControl.gameModel.word}',
        style: TextStyle(
            color: Colors.orangeAccent,
            fontSize: 20,
            height: 1.5,
            fontWeight: FontWeight.bold),
      );
    }
  }
}
