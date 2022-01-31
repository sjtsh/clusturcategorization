import 'package:flutter/material.dart';

import 'ChooseFolder/ChooseFolder.dart';
import 'ClusturedHome.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Clustured Home',
      theme: ThemeData(
      ),
      debugShowCheckedModeBanner: false,
      home: ChooseFolder(),
    );
  }
}
