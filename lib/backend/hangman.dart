import 'dart:async';
import 'dart:convert';
import 'package:flutter/services.dart' show rootBundle;
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:hangman_game/Info.dart';

class Hangman with ChangeNotifier {
  Set<String> _wordSets = Set();
  String _word;
  int _correct = 0;
  int _incorrect = 0;
  String _wordRepre = '';
  Set<String> _inputSet = Set();
  String _input = '';
  String _displayNote = 'go ahead';
  bool tryAgain = false;
  int kHangmanQuota = 1;

  String get input => _input;

  set input(String input) {
    _input = input;
    notifyListeners();
  }

  int get totalPlay {
    return (correct + incorrect);
  }

  String get displayNote => _displayNote;

  bool isWin() {
    if (word == wordRepre) {
      return true;
    }
    return false;
  }

  bool isLose() {
    if (incorrect >= 3) {
      return true;
    }
    return false;
  }

  Hangman() {
    initial();
  }

  void initial({String fileName = 'assets/words.txt'}) async {
    // parse the file and save to _wordSets
    await parseFile(fileName);
    selectWord();

    for (var i = 0; i < _word.length; i++) {
      _wordRepre += ' ';
    }
    notifyListeners();
    print(word);
  }

  void shuffle() {
    _inputSet = Set();
    _correct = 0;
    _incorrect = 0;
    _displayNote = 'go ahead';
    selectWord();
    _wordRepre = '';
    for (int i = 0; i < word.length; i++) {
      _wordRepre += ' ';
    }
    notifyListeners();
  }

  Future<void> parseFile(String fileName) async {
    String data = await rootBundle.loadString(fileName);
    LineSplitter.split(data).forEach(
      (String word) {
        if (isOkWord(word)) {
          _wordSets.add(word);
        }
      },
    );
    // print(_wordSets.length);
  }

  bool isOkWord(String word) {
    RegExp pattern = RegExp(
        "([^(A-Z\\.'\\s\\d\\-)]*[A-Z\\.'\\s\\d\\-]+[^(A-Z\\.'\\s\\d\\-)]*)");
    if (pattern.hasMatch(word)) {
      return false;
    }
    return true;
  }

  void selectWord() {
    Random rand = Random();
    int randomNumber = rand.nextInt(_wordSets.length);
    int index = 0;

    for (String w in _wordSets) {
      if (randomNumber == index) {
        _word = w;
        break;
      }
      index++;
    }
  }

  void addCorrectCount() {
    this._correct++;
    notifyListeners();
  }

  void addIncorrectCount() {
    this._incorrect++;
    notifyListeners();
  }

  Set<String> get wordSets {
    return _wordSets;
  }

  String get word => _word;

  int get correct => _correct;

  int get incorrect => _incorrect;

  void setWordRepre(String input) {
    if (input == '') {
      _displayNote = 'Input something';
    }
    if (hasInputBefore(input)) {
      _displayNote = 'You have input this before';
    } else if (!word.contains(input)) {
      addInputSet(input);
      addIncorrectCount();
      _displayNote = 'Incorrect, Total input times: $totalPlay';
    } else if (!this._wordRepre.contains(input)) {
      addCorrectCount();
      addInputSet(input);
      _displayNote = 'Correct: Total input times: $totalPlay';
      Map<int, String> wordMap = {};
      List<String> wordRepreArray = _wordRepre.split('');

      for (var i = 0; i < word.length; i++) {
        if (word[i] == input) {
          wordMap[i] = input;
        }
      }
      wordMap.forEach((key, value) => wordRepreArray[key] = value);
      _wordRepre = wordRepreArray.join();
    }

    notifyListeners();
  }

  void showLoseDialog(BuildContext context, FocusNode node) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(
          '😢 You Lose',
          style: TextStyle(color: Colors.white),
        ),
        content: LoseInfo(
          hangmanControl: this,
          withAns: false,
        ),
        actions: [
          TextButton(
            child: Text(
              'Try Again',
              style: TextStyle(color: Colors.white),
            ),
            onPressed: () {
              Navigator.of(context).pop();
              _inputSet = Set();
              _correct = 0;
              _incorrect = 0;
              _displayNote = 'go ahead';
              _wordRepre = '';
              node.requestFocus();
              for (var i = 0; i < _word.length; i++) {
                _wordRepre += ' ';
              }
              notifyListeners();
            },
          ),
          TextButton(
            child: Text(
              'Reveal Answer',
              style: TextStyle(color: Colors.white),
            ),
            onPressed: () {
              showLoseDialogWithAns(context, node);
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

              Navigator.of(context).popUntil(ModalRoute.withName('game_page'));
              shuffle();
            },
          ),
        ],
      ),
    );
  }

  void showLoseDialogWithAns(
    BuildContext context,
    FocusNode node,
  ) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('😢 You Lose'),
        content: LoseInfo(
          hangmanControl: this,
          withAns: true,
        ),
        actions: [
          TextButton(
            child: Text(
              'Close',
              style: TextStyle(color: Colors.white),
            ),
            onPressed: () {
              Navigator.popUntil(context, ModalRoute.withName('game_page'));
              shuffle();
              node.unfocus();
            },
          ),
        ],
      ),
    );
  }

  void showWinDialog(BuildContext context, FocusNode node) {
    showDialog(
        context: context,
        builder: (_) => AlertDialog(
              title: Text('😃 You Win!'),
              content: WinInfo(
                hangmanControl: this,
              ),
              actions: <Widget>[
                TextButton(
                  child: Text(
                    'Close!',
                    style: TextStyle(color: Colors.white),
                  ),
                  onPressed: () {
                    Navigator.of(context).pop();
                    shuffle();
                    node.unfocus();
                  },
                )
              ],
            ));
  }

  String get wordRepre => _wordRepre;

  void addInputSet(String input) {
    _inputSet.add(input);
    notifyListeners();
  }

  Set<String> get inputSet => _inputSet;

  bool hasInputBefore(String input) {
    if (inputSet.contains(input)) {
      return true;
    }
    return false;
  }

  @override
  String toString() => wordRepre;
}
