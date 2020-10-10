import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hangman_rebuild/app/modules/game/gamePage_binding.dart';
import 'package:hangman_rebuild/app/modules/game/gamePage_view.dart';
import 'package:hangman_rebuild/app/modules/home/homePage_controller.dart';

class HomePageView extends GetView<HomePageController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Hangman Game'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                'Select Game Mode',
                style: TextStyle(
                  fontSize: 18,
                ),
              ),
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: List<Text>.generate(
                3,
                (index) => Text(
                  ['Easy', 'Midium', 'Hard'][index],
                  style: TextStyle(fontSize: 16, color: Colors.grey[700]),
                ),
              )
                  .map(
                    (e) => Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: TextButton(
                          style: ButtonStyle(backgroundColor: MyColor()),
                          onPressed: () => Get.to(
                              GamePageView(
                                mode: e.data,
                              ),
                              binding: GamePageBinding()),
                          child: e),
                    ),
                  )
                  .toList(),
            ),
          ],
        ),
      ),
    );
  }
}

class MyColor extends MaterialStateColor {
  static const int _defaultColor = 0xcafefeed;
  static const int _pressedColor = 0xdeadbeef;

  const MyColor() : super(_defaultColor);

  @override
  Color resolve(Set<MaterialState> states) {
    if (states.contains(MaterialState.pressed)) {
      return const Color(_pressedColor);
    }
    return const Color(_defaultColor);
  }
}
