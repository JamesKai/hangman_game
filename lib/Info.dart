import 'package:flutter/material.dart';

import 'backend/hangman.dart';

class PlayInfo extends StatelessWidget {
  const PlayInfo({
    Key key,
    @required this.hangmanControl,
  }) : super(key: key);

  final Hangman hangmanControl;

  @override
  Widget build(BuildContext context) {
    return Text(hangmanControl.displayNote);
  }
}

class WinInfo extends StatelessWidget {
  final Hangman hangmanControl;

  const WinInfo({
    Key key,
    @required this.hangmanControl,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Text(
      'Congrats, you are word masters to win the game',
      textAlign: TextAlign.center,
      style: TextStyle(
          color: Colors.orangeAccent,
          fontSize: 20,
          height: 1.5,
          fontWeight: FontWeight.bold),
    );
  }
}

class LoseInfo extends StatelessWidget {
  final Hangman hangmanControl;
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
        textAlign: TextAlign.center,
        style: TextStyle(
            color: Colors.orangeAccent,
            fontSize: 20,
            height: 1.5,
            fontWeight: FontWeight.bold),
      );
    } else {
      return Text(
        'Sorry, you did not win the game. \nAnswer: ${hangmanControl.word}',
        textAlign: TextAlign.center,
        style: TextStyle(
            color: Colors.orangeAccent,
            fontSize: 20,
            height: 1.5,
            fontWeight: FontWeight.bold),
      );
    }
  }
}
