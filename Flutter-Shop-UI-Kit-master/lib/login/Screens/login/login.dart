import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:stylish/app_data.dart';
import 'package:stylish/login/Screens/register/register.dart';
import 'package:http/http.dart' as http;
import 'package:stylish/modal_widget.dart';
import 'package:stylish/screens/home/home_screen.dart';

class LoginScreen extends StatelessWidget {
  TextEditingController controllerUsername = TextEditingController();
  TextEditingController controllerPassword = TextEditingController();
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Container(
            alignment: Alignment.centerLeft,
            padding: const EdgeInsets.symmetric(horizontal: 40),
            child: const Text(
              "LOGIN",
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF2661FA),
                  fontSize: 36),
              textAlign: TextAlign.left,
            ),
          ),
          SizedBox(height: size.height * 0.03),
          Container(
            alignment: Alignment.center,
            margin: const EdgeInsets.symmetric(horizontal: 40),
            child: TextField(
              decoration: const InputDecoration(labelText: "Username"),
              controller: controllerUsername,
            ),
          ),
          SizedBox(height: size.height * 0.03),
          Container(
            alignment: Alignment.center,
            margin: const EdgeInsets.symmetric(horizontal: 40),
            child: TextField(
              decoration: const InputDecoration(labelText: "Password"),
              obscureText: true,
              controller: controllerPassword,
            ),
          ),
          Container(
            alignment: Alignment.centerRight,
            margin: const EdgeInsets.symmetric(horizontal: 40, vertical: 10),
            child: const Text(
              "Forgot your password?",
              style: TextStyle(fontSize: 12, color: Color(0XFF2661FA)),
            ),
          ),
          SizedBox(height: size.height * 0.05),
          SizedBox(
            // alignment: Alignment.center,
            height: 50.0,
            width: size.width * 0.5,
            child: ElevatedButton(
              onPressed: () async {
                String url = "http://localhost:3000/login";
                Map user = {
                  "username": controllerUsername.text,
                  "password": controllerPassword.text
                };
                http.Response response = await http.post(
                  Uri.parse(url),
                  headers: {'Content-Type': 'application/json'},
                  body: jsonEncode(user),
                );
                // String? cookie = response;
                // print("COOKIE $cookie");
                // inspect(response);
                // print(respMap);

                Map respMap = jsonDecode(response.body);
                if (respMap["error"] == null) {
                  await AppData.storage
                      .write(key: "token", value: respMap["token"]);
                  await AppData.storage
                      .write(key: "userId", value: respMap["userId"]);
                  AppData.username = controllerUsername.text;
                  Navigator.of(context).pushAndRemoveUntil(
                      MaterialPageRoute(
                          builder: (context) => const HomeScreen()),
                      (route) => false);
                } else {
                  ModalWidget.show(
                      context,
                      AlertDialog(
                        // title: Text(""),
                        content: Text(respMap["error"]),
                        actions: [
                          TextButton(
                            child: Text("Aceptar"),
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                          ),
                        ],
                      ));
                }
              },
              style: ElevatedButton.styleFrom(
                shape: const StadiumBorder(),
              ),
              child: const Text(
                "LOGIN",
                textAlign: TextAlign.center,
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
          ),
          Container(
            alignment: Alignment.centerRight,
            margin: const EdgeInsets.symmetric(horizontal: 40, vertical: 10),
            child: GestureDetector(
              onTap: () => {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => RegisterScreen()))
              },
              child: const Text(
                "Don't Have an Account? Sign up",
                style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF2661FA)),
              ),
            ),
          )
        ],
      ),
    );
  }
}
