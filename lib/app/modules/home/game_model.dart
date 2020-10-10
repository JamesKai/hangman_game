import 'dart:math';

class GameModel {
  Set<String> wordSets;
  Set<String> inputSet;
  String word;
  int correctCount;
  int incorrectCount;
  var wordRepre = ' ';
  var displayNote = 'Go ahead';
  bool doTryAgain;
  var input = '';

  bool isWin() => word == wordRepre;

  bool isLose() => incorrectCount >= 3;

  int get totalPlay => correctCount + incorrectCount;

  bool hasInputBefore(String input) => inputSet.contains(input);

  void selectWord() {
    Random rand = Random();
    var randNum = rand.nextInt(wordSets.length);
    this.word = wordSets.elementAt(randNum);
  }

  void shuffle() {
    resetState();
    selectWord();
    wordRepre = ' ' * word.length;
  }

  void playAgain() {
    resetState();

    wordRepre = ' ' * word.length;
  }

  void resetState() {
    inputSet = Set();
    correctCount = 0;
    incorrectCount = 0;
    doTryAgain = false;
    displayNote = 'Go ahead';
    wordRepre = ' ';
  }

  void setWordRepre(String input) {
    displayNote = input == ''
        ? 'Input something'
        : hasInputBefore(input)
            ? 'You have input this before'
            : displayNote;
    if (!word.contains(input)) {
      inputSet.add(input);
      incorrectCount++;
      displayNote = 'Incorrect, total input times: $totalPlay';
    } else if (!this.wordRepre.contains(input)) {
      inputSet.add(input);
      correctCount++;
      displayNote = 'Correct, total input times: $totalPlay';

      wordRepre = List<String>.generate(
          word.length,
          (index) =>
              word.split('')[index] == input ? input : wordRepre[index]).join();
    }
  }
}
