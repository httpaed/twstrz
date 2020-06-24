import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'dart:io' show Platform;
import 'home.dart';
import 'speech.dart';
import 'var.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    if(Platform.isIOS)
      isIOS = true;
    colors(isDark, context);
    CupertinoThemeData themeC = CupertinoThemeData(brightness: brightness);
    ThemeData themeA = ThemeData(brightness: brightness);
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'twister',
      theme: (isIOS) ? themeC : themeA,
      home: MyHomePage(),
    );
  }
}



