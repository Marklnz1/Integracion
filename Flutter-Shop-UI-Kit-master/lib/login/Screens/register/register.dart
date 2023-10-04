import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:stylish/login/Screens/login/login.dart';
import 'package:http/http.dart' as http;

class RegisterScreen extends StatelessWidget {
  final TextEditingController controllerName = TextEditingController();
  final TextEditingController controllerUsername = TextEditingController();
  final TextEditingController controllerPhone = TextEditingController();
  final TextEditingController controllerPassword = TextEditingController();

  RegisterScreen({Key? key}) : super(key: key);
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
              "REGISTER",
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
              decoration: const InputDecoration(labelText: "Name"),
              controller: controllerName,
            ),
          ),
          SizedBox(height: size.height * 0.03),
          Container(
            alignment: Alignment.center,
            margin: const EdgeInsets.symmetric(horizontal: 40),
            child: TextField(
              decoration: const InputDecoration(labelText: "Mobile Number"),
              controller: controllerPhone,
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
              controller: controllerPassword,
              obscureText: true,
            ),
          ),
          SizedBox(height: size.height * 0.05),
          SizedBox(
            // alignment: Alignment.centerRight,
            height: 50.0,
            width: size.width * 0.5,
            // margin: EdgeInsets.symmetric(horizontal: 40, vertical: 10),
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                shape: const StadiumBorder(),
              ),
              onPressed: () async {
                String url = "http://localhost:3000/register";
                Map user = {
                  "name": controllerName.text,
                  "username": controllerUsername.text,
                  "phone": controllerPhone.text,
                  "password": controllerPassword.text
                };
                http.Response response = await http.post(
                  Uri.parse(url),
                  headers: {'Content-Type': 'application/json'},
                  body: jsonEncode(user),
                );
                Map respMap = jsonDecode(response.body);
              },
              // shape: RoundedRectangleBorder(
              //     borderRadius: BorderRadius.circular(80.0)),
              // textColor: Colors.white,
              // padding: const EdgeInsets.all(0),
              child: const Text(
                "SIGN UP",
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
                    MaterialPageRoute(builder: (context) => LoginScreen()))
              },
              child: const Text(
                "Already Have an Account? Sign in",
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
