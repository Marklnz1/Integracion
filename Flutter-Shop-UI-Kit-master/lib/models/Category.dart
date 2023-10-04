class Category {
  final String icon, title, spanishTitle;

  Category(
      {required this.icon, required this.title, required this.spanishTitle});
}

List<Category> demo_categories = [
  Category(
      icon: "assets/icons/dress.svg", title: "Dress", spanishTitle: "Vestidos"),
  Category(
      icon: "assets/icons/shirt.svg", title: "Shirt", spanishTitle: "Camisas"),
  Category(
      icon: "assets/icons/pants.svg",
      title: "Pants",
      spanishTitle: "Pantalones"),
  Category(
      icon: "assets/icons/Tshirt.svg", title: "Tshirt", spanishTitle: "Polos"),
];
