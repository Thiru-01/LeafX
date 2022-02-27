import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:plantix/constant.dart';
import 'package:plantix/views/backgroundscreen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'LeafX',
      theme: ThemeData(primarySwatch: primaryswatch, fontFamily: "Oswald"),
      home: BackgroundScreen(),
    );
  }
}
