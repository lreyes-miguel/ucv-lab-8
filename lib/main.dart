import 'package:flutter/material.dart';
import 'package:ucv_laboratorio_8/pages/home_page.dart';
import 'package:ucv_laboratorio_8/pages/register_page.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'UCV Laboratorio 8',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => HomePage(),
        '/register': (context) => RegisterPage(),
      },
    );
  }
}