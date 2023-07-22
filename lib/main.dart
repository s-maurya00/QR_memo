import 'package:flutter/material.dart';

import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:get_storage/get_storage.dart';

import 'app/common/services/theme_services.dart';

import 'app/common/utils/theme.dart';

import 'app/pages/home_page.dart';

import 'app/database/db_helper.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await GetStorage.init();

  await DBHelper.initDb();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Expiration Tracker',
      theme: Themes.light,
      darkTheme: Themes.dark,
      themeMode: ThemeController().theme,
      debugShowCheckedModeBanner: false,
      home: const HomePage(),
    );
  }
}
