import 'package:flutter/material.dart';
import 'package:flutter_config/flutter_config.dart';
import 'package:me_indik_app/constants/movie_constants.dart';
import 'package:me_indik_app/core/app_theme.dart';
import 'package:me_indik_app/view/pages/movie_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await FlutterConfig.loadEnvVariables();

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: kAppName,
      theme: kThemeApp,
      home: MoviePage(),
    );
  }
}
