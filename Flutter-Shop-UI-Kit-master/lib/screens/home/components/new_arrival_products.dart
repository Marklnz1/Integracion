import 'package:basic_utils/basic_utils.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:stylish/models/Product.dart';
import 'package:stylish/screens/details/details_screen.dart';
import 'package:stylish/screens/home/product_provider.dart';

import '../../../constants.dart';
import 'product_card.dart';
import 'section_title.dart';

class NewArrivalProducts extends StatelessWidget {
  const NewArrivalProducts({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    ProductProvider productProvider = context.watch<ProductProvider>();
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: defaultPadding),
          child: SectionTitle(
            title: "Productos",
            pressSeeAll: () {
              productProvider.loadAllProducts();
            },
          ),
        ),
        productProvider.showProducts.length == 0
            ? Text("No se encontraron productos")
            : SingleChildScrollView(
                child: Wrap(
                  alignment: WrapAlignment.center,
                  runAlignment: WrapAlignment.start,
                  spacing: 2,
                  runSpacing: 2,
                  children: List.generate(
                    productProvider.showProducts.length,
                    (index) => Padding(
                      padding: const EdgeInsets.only(right: defaultPadding),
                      child: ProductCard(
                        stock: productProvider.showProducts[index].stock,
                        title: StringUtils.capitalize(
                            productProvider.showProducts[index].title,
                            allWords: true),
                        image: productProvider.showProducts[index].image,
                        price: productProvider.showProducts[index].price,
                        bgColor: productProvider.showProducts[index].bgColor,
                        press: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => DetailsScreen(
                                    product:
                                        productProvider.showProducts[index]),
                              ));
                        },
                      ),
                    ),
                  ),
                ),
              ),
      ],
    );
  }
}
