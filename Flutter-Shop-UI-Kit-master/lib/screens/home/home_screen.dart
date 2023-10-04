import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:stylish/constants.dart';
import 'package:stylish/models/Payment.dart';
import 'package:stylish/screens/home/product_provider.dart';
import 'package:stylish/screens/payment_page/payment_list_page.dart';
import 'package:stylish/screens/payment_page/payment_provider.dart';

import 'components/categories.dart';
import 'components/new_arrival_products.dart';
import 'components/popular_products.dart';
import 'components/search_form.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => ProductProvider()),
        ChangeNotifierProvider(create: (_) => PaymentProvider())
      ],
      builder: (context, child) {
        PaymentProvider paymentProvider = context.read<PaymentProvider>();
        return Scaffold(
          appBar: AppBar(
            leading: IconButton(
              onPressed: () {},
              icon: SvgPicture.asset("assets/icons/menu.svg"),
            ),
            title: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SvgPicture.asset("assets/icons/Location.svg"),
                const SizedBox(width: defaultPadding / 2),
                Text(
                  "15/2",
                  style: Theme.of(context).textTheme.bodyText1,
                ),
              ],
            ),
            actions: [
              IconButton(
                icon: SvgPicture.asset("assets/icons/Notification.svg"),
                onPressed: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                        builder: (context) => MultiProvider(
                              providers: [
                                ChangeNotifierProvider.value(
                                    value: paymentProvider)
                              ],
                              builder: (a, b) => PaymentListPage(
                                payments: [
                                  // for (int i = 0; i < 100; i++)
                                  //   Payment(123, "asdas", DateTime.now())
                                ],
                              ),
                            )),
                  );
                },
              ),
            ],
          ),
          body: SingleChildScrollView(
            physics: const BouncingScrollPhysics(
                parent: AlwaysScrollableScrollPhysics()),
            padding: const EdgeInsets.all(defaultPadding),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Explora",
                  style: Theme.of(context).textTheme.headline4!.copyWith(
                      fontWeight: FontWeight.w500, color: Colors.black),
                ),
                const Text(
                  "los mejores Outfits para ti",
                  style: TextStyle(fontSize: 18),
                ),
                const Padding(
                  padding: EdgeInsets.symmetric(vertical: defaultPadding),
                  child: SearchForm(),
                ),
                const Categories(),
                const NewArrivalProducts(),
                // const PopularProducts(),
              ],
            ),
          ),
        );
      },
    );
  }
}
