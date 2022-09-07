import 'dart:io';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tea/provider/noteProvider.dart';
import 'package:tea/provider/todoProvider.dart';
import 'package:tea/utils/routes.dart';
import 'package:tea/utils/themes.dart';
import 'package:tea/view/MainScreen.dart';
import 'package:tea/utils/locator.dart';

void main() {
  setupLocator();
  HttpOverrides.global = new MyHttpOverrides();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (_) => TodoProvider()),
          ChangeNotifierProvider(create: (_) => NoteProvider()),
        ],
        child: MaterialApp(
          onGenerateRoute: AppRoute.generateRoute,
          debugShowCheckedModeBanner: false,
          title: 'Taking Notes',
          initialRoute: homeRoute,
          theme: MyTheme.mytheme,
          home: MainScreen(),
        ));
  }
}

class MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext context) {
    return super.createHttpClient(context)
      ..badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
  }
}
