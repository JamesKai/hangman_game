import 'package:flutter/material.dart';
import 'package:hangman_game/char_card.dart';
import 'Info.dart';
import 'backend/hangman.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => Hangman(),
      child: MaterialApp(
        title: 'Hangman Game',
        theme: ThemeData.dark(),
        initialRoute: 'game_page',
        routes: {'game_page': (context) => MyHomePage()},
      ),
    );
  }
}

class MyHomePage extends StatelessWidget {
  MyHomePage();

  @override
  Widget build(BuildContext context) {
    var hangmanControl = Provider.of<Hangman>(context);
    var myTextController = TextEditingController(
      text: hangmanControl.input,
    );
    myTextController.selection = TextSelection.fromPosition(
        TextPosition(offset: myTextController.text.length));
    return Scaffold(
      appBar: AppBar(
        title: Text('Hangman Game'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
                padding: const EdgeInsets.all(10.0),
                child: CharacterList(wordRepre: hangmanControl.wordRepre)),
            Padding(
              padding: const EdgeInsets.only(left: 100.0, right: 100),
              child: TextField(
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 30),
                maxLength: 1,
                controller: myTextController,
                onChanged: (value) {
                  hangmanControl.input = value;
                },
              ),
            ),
            FlatButton(
                color: Colors.teal[300],
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20)),
                child: Text('Confirm'),
                onPressed: () {
                  hangmanControl.setWordRepre(hangmanControl.input);
                  hangmanControl.input = '';
                  if (hangmanControl.isWin()) {
                    hangmanControl.showWinDialog(context);
                  } else if (hangmanControl.isLose()) {
                    hangmanControl.showLoseDialog(context);
                  }
                }),
            Padding(
              padding: const EdgeInsets.all(15.0),
              child: RaisedButton(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20)),
                  child: Text('New Game'),
                  onPressed: () {
                    hangmanControl.shuffle();
                  }),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Card(
                child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: PlayInfo(hangmanControl: hangmanControl)),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
