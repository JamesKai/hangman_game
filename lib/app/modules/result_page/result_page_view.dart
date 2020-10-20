import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hangman_rebuild/app/modules/game/gamePage_controller.dart';
import 'package:hangman_rebuild/app/modules/result_page/result_page_controller.dart';

class ResultPageView extends GetView<ResultPageController> {
  @override
  Widget build(BuildContext context) {
    var results = Get.find<GamePageController>().resultBox;
    return Scaffold(
      appBar: AppBar(
        title: Text('ResultPageView'),
        centerTitle: true,
      ),
      body: Center(
        child: ListView.builder(
          itemCount: results.length,
          itemBuilder: (BuildContext context, int index) {
            return ListTile(title: Text(results.get(index)));
          },
        ),
      ),
    );
  }
}
