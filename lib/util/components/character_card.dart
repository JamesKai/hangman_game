import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hangman_rebuild/app/modules/game/gamePage_controller.dart';

/// Create single character card widget
///
/// Take one optional parameter: String [char]
class CharacterCard extends StatelessWidget {
  final String char;
  CharacterCard({this.char = 'a'});
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Expanded(
        child: Card(
          child: Padding(
            padding: const EdgeInsets.only(bottom: 2.0),
            child: Center(
              child: FittedBox(
                child: Text(
                  char,
                  style: TextStyle(fontSize: 30),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class CharacterList extends StatelessWidget {
  final String wordRepre;
  CharacterList({@required this.wordRepre});
  List<Widget> get charLst {
    return [
      for (int i = 0; i < wordRepre.length; i++)
        GetBuilder<GamePageController>(
          init: GamePageController(),
          builder: (c) {
            return CharacterCard(
              char: c.gameModel.wordRepre[i],
            );
          },
        )
    ];
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Row(
        children: charLst,
        mainAxisAlignment: MainAxisAlignment.center,
      ),
    );
  }
}
