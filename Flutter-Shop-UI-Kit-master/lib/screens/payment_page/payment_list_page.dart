import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:stylish/models/Payment.dart';
import 'package:stylish/screens/payment_page/payment_provider.dart';

class PaymentListPage extends StatefulWidget {
  final List<Payment> payments;
  const PaymentListPage({Key? key, required this.payments}) : super(key: key);

  @override
  State<PaymentListPage> createState() => _PaymentListPageState();
}

class _PaymentListPageState extends State<PaymentListPage> {
  @override
  Widget build(BuildContext context) {
    PaymentProvider paymentProvider = context.read<PaymentProvider>();

    if (paymentProvider.payments == null) {
      paymentProvider.loadPayments().then((value) {
        setState(() {});
      });
    }
    List<Payment> payments =
        paymentProvider.payments != null ? paymentProvider.payments! : [];
    return Scaffold(
        appBar: AppBar(
          leading: const BackButton(color: Colors.black),
          title: Text(
            'Historial de pagos',
            style: TextStyle(color: Colors.black),
          ),
          centerTitle: true,
        ),
        body: SafeArea(
            child: Container(
          child: Container(
              height: 550,
              child: payments.isEmpty
                  ? Center(
                      child: Text(
                      'No Transactions added yet!',
                      style: Theme.of(context).textTheme.titleLarge,
                    )

                      // Container(
                      //   height: 400,
                      //   child: Image.asset(
                      //     'assets/images/waiting.png',
                      //     fit: BoxFit.cover,
                      //   ),
                      // ),

                      )
                  : ListView.builder(
                      itemBuilder: (ctx, index) {
                        return Card(
                          elevation: 5,
                          margin:
                              EdgeInsets.symmetric(vertical: 8, horizontal: 5),
                          child: ListTile(
                            leading: CircleAvatar(
                              radius: 30,
                              child: Padding(
                                padding: const EdgeInsets.all(6.0),
                                child: FittedBox(
                                    child: Text('\$${payments[index].amount}')),
                              ),
                            ),
                            title: Text(
                              payments[index].title,
                              style: Theme.of(context).textTheme.titleLarge,
                            ),
                            subtitle: Text(
                              payments[index].date,
                            ),
                            // trailing: IconButton(
                            //   icon: Icon(Icons.delete),
                            //   color: Theme.of(context).errorColor,
                            //   onPressed: () =>
                            //       deleteTx(this.transactions[index].id),
                            // ),
                          ),
                        );
                      },
                      itemCount: payments.length,
                    )),
        )));
  }
}
