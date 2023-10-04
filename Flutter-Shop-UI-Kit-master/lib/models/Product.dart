import 'package:flutter/material.dart';

class Product {
  final String title, description, id, category;
  late String image;
  final double price;
  final int stock;
  final Color bgColor;

  Product({
    required this.id,
    required this.title,
    required this.price,
    required this.description,
    required this.stock,
    required this.category,
    this.bgColor = const Color(0xFFEFEFF2),
  }) {
    print("CATEGORIA $category");
    switch (category) {
      case "dress":
        image = "assets/images/dress.png";
        break;
      case "Tshirt":
        image = "assets/images/polos.jpg";

        break;
      case "pants":
        image = "assets/images/pants.png";

        break;
      case "shirt":
        image = "assets/images/product_2.png";

        break;
      default:
        image = "";
    }
  }
}

// List<Product> demo_product = [
//   Product(
//       image: "assets/images/product_0.png",
//       title: "Long Sleeve Shirts",
//       price: 165,
//       bgColor: const Color(0xFFFEFBF9),
//       description: "asdas dasd asd "),
//   Product(
//       image: "assets/images/product_1.png",
//       title: "Casual Henley Shirts",
//       price: 99,
//       description: "asdas dasd asd "),
//   Product(
//       image: "assets/images/product_2.png",
//       title: "Curved Hem Shirts",
//       price: 180,
//       bgColor: const Color(0xFFF8FEFB),
//       description: "asdas dasd asd "),
//   Product(
//       image: "assets/images/product_3.png",
//       title: "Casual Nolin",
//       price: 149,
//       bgColor: const Color(0xFFEEEEED),
//       description: "asdas dasd asd "),
//   Product(
//       image: "assets/images/product_0.png",
//       title: "Long Sleeve Shirts",
//       price: 165,
//       bgColor: const Color(0xFFFEFBF9),
//       description: "asdas dasd asd "),
//   Product(
//       image: "assets/images/product_1.png",
//       title: "Casual Henley Shirts",
//       price: 99,
//       description: "asdas dasd asd "),
//   Product(
//       image: "assets/images/product_2.png",
//       title: "Curved Hem Shirts",
//       price: 180,
//       bgColor: const Color(0xFFF8FEFB),
//       description: "asdas dasd asd "),
//   Product(
//       image: "assets/images/product_3.png",
//       title: "Casual Nolin",
//       price: 149,
//       bgColor: const Color(0xFFEEEEED),
//       description: "asdas dasd asd "),
//   Product(
//       image: "assets/images/product_0.png",
//       title: "Long Sleeve Shirts",
//       price: 165,
//       bgColor: const Color(0xFFFEFBF9),
//       description: "asdas dasd asd "),
//   Product(
//       image: "assets/images/product_1.png",
//       title: "Casual Henley Shirts",
//       price: 99,
//       description: "asdas dasd asd "),
//   Product(
//       image: "assets/images/product_2.png",
//       title: "Curved Hem Shirts",
//       price: 180,
//       bgColor: const Color(0xFFF8FEFB),
//       description: "asdas dasd asd "),
//   Product(
//       image: "assets/images/product_3.png",
//       title: "Casual Nolin",
//       price: 149,
//       bgColor: const Color(0xFFEEEEED),
//       description: "asdas dasd asd "),
//   Product(
//       image: "assets/images/product_0.png",
//       title: "Long Sleeve Shirts",
//       price: 165,
//       bgColor: const Color(0xFFFEFBF9),
//       description: "asdas dasd asd "),
//   Product(
//       image: "assets/images/product_1.png",
//       title: "Casual Henley Shirts",
//       price: 99,
//       description: "asdas dasd asd "),
//   Product(
//       image: "assets/images/product_2.png",
//       title: "Curved Hem Shirts",
//       price: 180,
//       bgColor: const Color(0xFFF8FEFB),
//       description: "asdas dasd asd "),
//   Product(
//       image: "assets/images/product_3.png",
//       title: "Casual Nolin",
//       price: 149,
//       bgColor: const Color(0xFFEEEEED),
//       description: "asdas dasd asd "),
//   Product(
//       image: "assets/images/product_0.png",
//       title: "Long Sleeve Shirts",
//       price: 165,
//       bgColor: const Color(0xFFFEFBF9),
//       description: "asdas dasd asd "),
//   Product(
//       image: "assets/images/product_1.png",
//       title: "Casual Henley Shirts",
//       price: 99,
//       description: "asdas dasd asd "),
//   Product(
//       image: "assets/images/product_2.png",
//       title: "Curved Hem Shirts",
//       price: 180,
//       bgColor: const Color(0xFFF8FEFB),
//       description: "asdas dasd asd "),
//   Product(
//       image: "assets/images/product_3.png",
//       title: "Casual Nolin",
//       price: 149,
//       bgColor: const Color(0xFFEEEEED),
//       description: "asdas dasd asd "),
//   Product(
//       image: "assets/images/product_0.png",
//       title: "Long Sleeve Shirts",
//       price: 165,
//       bgColor: const Color(0xFFFEFBF9),
//       description: "asdas dasd asd "),
//   Product(
//       image: "assets/images/product_1.png",
//       title: "Casual Henley Shirts",
//       price: 99,
//       description: "asdas dasd asd "),
//   Product(
//       image: "assets/images/product_2.png",
//       title: "Curved Hem Shirts",
//       price: 180,
//       bgColor: const Color(0xFFF8FEFB),
//       description: "asdas dasd asd "),
//   Product(
//       image: "assets/images/product_3.png",
//       title: "Casual Nolin",
//       price: 149,
//       bgColor: const Color(0xFFEEEEED),
//       description: "asdas dasd asd "),
//   Product(
//       image: "assets/images/product_0.png",
//       title: "Long Sleeve Shirts",
//       price: 165,
//       bgColor: const Color(0xFFFEFBF9),
//       description: "asdas dasd asd "),
//   Product(
//       image: "assets/images/product_1.png",
//       title: "Casual Henley Shirts",
//       price: 99,
//       description: "asdas dasd asd "),
//   Product(
//       image: "assets/images/product_2.png",
//       title: "Curved Hem Shirts",
//       price: 180,
//       bgColor: const Color(0xFFF8FEFB),
//       description: "asdas dasd asd "),
//   Product(
//       image: "assets/images/product_3.png",
//       title: "Casual Nolin",
//       price: 149,
//       bgColor: const Color(0xFFEEEEED),
//       description: "asdas dasd asd "),
//   Product(
//       image: "assets/images/product_0.png",
//       title: "Long Sleeve Shirts",
//       price: 165,
//       bgColor: const Color(0xFFFEFBF9),
//       description: "asdas dasd asd "),
//   Product(
//       image: "assets/images/product_1.png",
//       title: "Casual Henley Shirts",
//       price: 99,
//       description: "asdas dasd asd "),
//   Product(
//       image: "assets/images/product_2.png",
//       title: "Curved Hem Shirts",
//       price: 180,
//       bgColor: const Color(0xFFF8FEFB),
//       description: "asdas dasd asd "),
//   Product(
//       image: "assets/images/product_3.png",
//       title: "Casual Nolin",
//       price: 149,
//       bgColor: const Color(0xFFEEEEED),
//       description: "asdas dasd asd "),
// ];
