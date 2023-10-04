import 'dart:convert';
import 'package:stylish/app_data.dart';
import 'package:stylish/constants.dart';

import 'package:flutter/material.dart';
import 'package:flutter_credit_card/credit_card_brand.dart';
import 'package:flutter_credit_card/flutter_credit_card.dart';
import 'package:stylish/modal_widget.dart';
import 'package:stylish/models/Product.dart';
import 'package:http/http.dart' as http;
import 'package:stylish/screens/home/home_screen.dart';

class PaymentPage extends StatefulWidget {
  final Product product;
  const PaymentPage({required this.product, Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return PaymentPageState();
  }
}

class PaymentPageState extends State<PaymentPage> {
  String cardNumber = '';
  String expiryDate = '';
  String cardHolderName = '';
  String cvvCode = '';
  bool isCvvFocused = false;
  bool isLoading = false;
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Stack(
      fit: StackFit.expand,
      children: [
        Scaffold(
          appBar: AppBar(
            leading: const BackButton(color: Colors.black),
            title: Text('Credit Card'),
          ),
          body: SafeArea(
            child: Column(
              children: <Widget>[
                SizedBox(
                  width: 500,
                  height: 250,
                  child: CreditCardWidget(
                    cardNumber: cardNumber,
                    expiryDate: expiryDate,
                    cardHolderName: cardHolderName,
                    cvvCode: cvvCode,
                    showBackView: isCvvFocused,
                    onCreditCardWidgetChange: (CreditCardBrand cardBrand) {},
                  ),
                ),
                Expanded(
                  child: SingleChildScrollView(
                    child: CreditCardForm(
                      formKey: formKey, // Required
                      onCreditCardModelChange:
                          onCreditCardModelChange, // Required
                      themeColor: Colors.red,
                      obscureCvv: true,
                      obscureNumber: true,
                      isHolderNameVisible: true,
                      isCardNumberVisible: true,
                      isExpiryDateVisible: true,
                      cardNumberDecoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'Number',
                        hintText: 'XXXX XXXX XXXX XXXX',
                      ),
                      expiryDateDecoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'Expired Date',
                        hintText: 'XX/XX',
                      ),
                      cvvCodeDecoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'CVV',
                        hintText: 'XXX',
                      ),
                      cardHolderDecoration: const InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: 'Card Holder',
                          hintText: "XXXX XXXX"),
                      cardNumber: '',
                      expiryDate: '',
                      cardHolderName: '',
                      cvvCode: '',
                    ),
                  ),
                ),
                Center(
                  child: SizedBox(
                    width: 200,
                    height: 48,
                    child: ElevatedButton(
                      onPressed: () {
                        //Navigator.of(context).pop();
                        initiatePayment();
                      },
                      style: ElevatedButton.styleFrom(
                          primary: primaryColor, shape: const StadiumBorder()),
                      child: const Text("Confirmar Compra"),
                    ),
                  ),
                ),
                SizedBox(
                  height: 30,
                ),
              ],
            ),
          ),
        ),
        isLoading
            ? Container(
                color: Colors.black.withOpacity(0.5),
                child: const Center(
                  child:
                      CircularProgressIndicator(), // Se puede personalizar el color, el tamaño y el valor del indicador
                ),
              )
            : Container(),
      ],
    );
  }

  void initiatePayment() async {
    if (!formKey.currentState!.validate()) {
      ModalWidget.show(
          context,
          AlertDialog(
            title: Text("La tarjeta no es valida"),
            content: Text("Ingrese los campos correctamente"),
            actions: [
              TextButton(
                child: Text("Aceptar"),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          ));
      return;
    }
    // Obtener la url de la api
    setState(() {
      isLoading = true;
    });
    String url = 'http://localhost:3000/initiatePayment';
    String? userdId = await AppData.storage.read(key: "userId");
    Map payment = {
      "userId": userdId,
      "currency": "PEN",
      "description": "",
      "crediCard": {
        "cardNumber": cardNumber,
        "cardHolder": cardHolderName,
        "expirationDate": expiryDate,
        "securityCode": cvvCode
      },
      "products": [
        {
          "id": widget.product.id,
          "name": widget.product.title,
          "quantity": 1,
          "price": widget.product.price
        }
      ]
    };
    // print(object)
    // Crear un objeto de tipo http.Response con el resultado del post
    http.Response response = await http.post(
      Uri.parse(url),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(payment),
    );
    Map respMap = jsonDecode(response.body);
    if (respMap["transactionId"] != null) {
      ModalWidget.show(
          context,
          AlertDialog(
            title: Text("Transacción exitosa"),
            content: Text("Has realizado el pago correctamente."),
            actions: [
              TextButton(
                child: Text("Aceptar"),
                onPressed: () {
                  Navigator.of(context).pushAndRemoveUntil(
                      MaterialPageRoute(
                          builder: (context) => const HomeScreen()),
                      (route) => false);
                },
              ),
            ],
          ));
    }
    // Actualizar el estado de la aplicación con el mensaje de la respuesta
    // setState(() {
    // message = response.body;
    // });
  }

  void onCreditCardModelChange(CreditCardModel creditCardModel) {
    setState(() {
      print(creditCardModel.cardNumber);

      cardNumber = creditCardModel.cardNumber;
      expiryDate = creditCardModel.expiryDate;
      cardHolderName = creditCardModel.cardHolderName;
      cvvCode = creditCardModel.cvvCode;
      isCvvFocused = creditCardModel.isCvvFocused;
    });
  }
}
