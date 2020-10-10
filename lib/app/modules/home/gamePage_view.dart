import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hangman_rebuild/app/modules/home/gamePage_controller.dart';
import 'package:hangman_rebuild/app/modules/home/game_model.dart';
import 'package:hangman_rebuild/util/components/character_card.dart';
import 'package:hangman_rebuild/util/services/file_manager.dart';
import 'gameDialog_view.dart';

class GamePageView extends GetView<GamePageController> {
  final FocusNode _charFocus = FocusNode();
  final String defalutFileName = 'assets/words.txt';
  @override
  Widget build(BuildContext context) {
    TextEditingController myTextController;
    return Scaffold(
      appBar: AppBar(
        title: Text('Hangman Game'),
      ),
      body: FutureBuilder<Set<String>>(
          future: ParseFiler.getWords(from: defalutFileName),
          builder: (context, snapshot) {
            // if not finished loading data -> black it with CircularProgressIndicator
            if (snapshot.connectionState != ConnectionState.done) {
              print('loading data');
              return Center(
                child: CircularProgressIndicator(
                  value: 1,
                ),
              );
            }
            // after retreiving data -> initialize controller's GameModel instance and set its wordSets property to the data
            controller.gameModel = GameModel();
            controller.gameModel.wordSets = snapshot.data;
            controller.gameModel.shuffle();

            myTextController =
                TextEditingController(text: controller.gameModel.input);
            myTextController.selection = TextSelection.fromPosition(
                TextPosition(offset: myTextController.text.length));
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: GetBuilder<GamePageController>(
                        builder: (c) {
                          return CharacterList(
                              wordRepre: c.gameModel.wordRepre);
                        },
                      )),
                  Padding(
                      padding: const EdgeInsets.only(left: 100.0, right: 100),
                      child: TextField(
                        // key: inputFieldKey,
                        focusNode: _charFocus,
                        textAlign: TextAlign.center,
                        style: TextStyle(fontSize: 30),
                        maxLength: 1,
                        controller: myTextController,
                        onChanged: (value) {
                          controller.gameModel.input = value;
                        },
                        textInputAction: TextInputAction.done,
                        onSubmitted: (value) {
                          controller.setWordRepre(controller.gameModel.input);
                          myTextController.clear();
                          if (controller.gameModel.isWin()) {
                            GameDialogView.showWinDialog(context, _charFocus);
                          } else if (controller.gameModel.isLose()) {
                            GameDialogView.showLoseDialog(context, _charFocus);
                          } else {
                            _charFocus.requestFocus();
                          }
                        },
                      )),
                  FlatButton(
                      color: Colors.teal[300],
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20)),
                      child: Text('Confirm'),
                      onPressed: () {
                        controller.setWordRepre(controller.gameModel.input);
                        myTextController.clear();
                        if (controller.gameModel.isWin()) {
                          GameDialogView.showWinDialog(context, _charFocus);
                        } else if (controller.gameModel.isLose()) {
                          GameDialogView.showLoseDialog(context, _charFocus);
                        }
                      }),
                  Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: RaisedButton(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20)),
                        child: Text('New Game'),
                        onPressed: () {
                          controller.shuffle();
                          _charFocus.unfocus();
                        }),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Card(
                      child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: GetBuilder<GamePageController>(
                            builder: (c) {
                              return PlayInfo(hangmanControl: c);
                            },
                          )),
                    ),
                  ),
                ],
              ),
            );
          }),
    );
  }
}
