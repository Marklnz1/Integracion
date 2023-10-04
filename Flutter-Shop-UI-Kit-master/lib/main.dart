import 'package:flutter/material.dart';
import 'package:stylish/constants.dart';
import 'package:stylish/login/Screens/login/login.dart';
import 'package:stylish/screens/home/home_screen.dart';
import 'package:stylish/app_data.dart';

void main() async {
  String? token = await AppData.storage.read(key: "token");
  runApp(MyApp(isLoggedIn: token != null));
}

class MyApp extends StatefulWidget {
  final bool isLoggedIn;
  const MyApp({Key? key, required this.isLoggedIn}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'The Flutter Way',
      theme: ThemeData(
        scaffoldBackgroundColor: bgColor,
        primarySwatch: Colors.blue,
        fontFamily: "Gordita",
        appBarTheme: const AppBarTheme(
          backgroundColor: Colors.transparent,
          elevation: 0,
        ),
        textTheme: const TextTheme(
          bodyText2: TextStyle(color: Colors.black54),
        ),
      ),
      home: widget.isLoggedIn ? const HomeScreen() : LoginScreen(),
    );
  }
}
