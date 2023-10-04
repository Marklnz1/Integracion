import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:stylish/app_data.dart';
import 'package:stylish/models/Payment.dart';

class PaymentProvider with ChangeNotifier {
  List<Payment>? payments;

  Future<void> loadPayments() async {
    String url = 'http://localhost:3000/payments';
    print("AQ ${await AppData.storage.read(key: "userId")}");
    Map user = {"userId": await AppData.storage.read(key: "userId")};
    // print(object)
    // Crear un objeto de tipo http.Response con el resultado del post
    http.Response response = await http.post(
      Uri.parse(url),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(user),
    );

    payments = [];
    Map respMap = jsonDecode(response.body);
    print(
      "${response.body} ${jsonDecode(response.body)["payments"]["payments"]}",
    );
    for (Map data in respMap["payments"]["payments"]) {
      // print("$data asasdasdasd");
      payments!.add(Payment(double.parse(data["price"]),
          int.parse(data["quantity"]), data["title"], data["date"]));
    }
    inspect(respMap);
  }
}
