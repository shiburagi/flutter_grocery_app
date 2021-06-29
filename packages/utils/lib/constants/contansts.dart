class ProductFilter {
  static const String search = "search";
  static const String buyAgain = "buyAgain";
  static const String recommend = "recommend";
  static const String alsoBought = "alsoBought";

  ProductFilter._();

  static bool isBasicFilter(String type) =>
      type == search ||
      type == buyAgain ||
      type == recommend ||
      type == alsoBought;
}
