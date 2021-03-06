import 'dart:math';

class GameModel {
  // wordSets should be instantiated before any operating functions is called
  Set<String> wordSets;
  Set<String> inputSet;
  String word;
  int correctCount;
  int incorrectCount;
  var wordRepre;
  var displayNote = 'Go ahead';
  bool doTryAgain = false;
  var input = '';
  var maxAttempCount;

  bool isWin() => word == wordRepre;

  bool isLose() => incorrectCount > maxAttempCount;

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
    print('start fresh: ' + word);
    wordRepre = ' ' * word.length;
  }

  void playAgain() {
    resetState();
    print('re-try: ' + word);
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
            ? 'You have input this before, ${maxAttempCount - incorrectCount} chance left'
            : displayNote;

    if (hasInputBefore(input)) return;
    if (!word.contains(input)) {
      inputSet.add(input);
      incorrectCount++;
      displayNote = isLose()
          ? 'You lose'
          : 'Incorrect, ${maxAttempCount - incorrectCount} chance left';
    } else if (!this.wordRepre.contains(input)) {
      inputSet.add(input);
      correctCount++;
      displayNote = 'Correct, ${maxAttempCount - incorrectCount} chance left';
      wordRepre = List<String>.generate(
          word.length,
          (index) =>
              word.split('')[index] == input ? input : wordRepre[index]).join();
    }
  }
}
