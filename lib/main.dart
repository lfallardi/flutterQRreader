import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:qr_lector/src/pages/home_page.dart';
 
void main() => runApp(MyApp());
 
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle.dark.copyWith(
        statusBarColor: Colors.transparent
      ) 
    );

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'QR Reader',
      initialRoute: 'home',
      routes: {
        'home': (BuildContext context) => HomePage(),
      },
      theme: ThemeData(
        primaryColor: Colors.red[900]
      ),
    );
  }
}