import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'app/routes/app_pages.dart';
import 'package:hive_flutter/hive_flutter.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  Hive.initFlutter();

  await Hive.openBox<String>('resultBox');
  runApp(
    GetMaterialApp(
      title: "Application",
      initialRoute: AppPages.INITIAL,
      getPages: AppPages.pages,
      theme: ThemeData.dark(),
      defaultTransition: Transition.cupertino,
    ),
  );
}
