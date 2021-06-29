import 'package:business_logic/business_logic.dart';
import 'package:catalog/catalog.dart';
import 'package:catalog/views/suggestions.dart';
import 'package:flutter/material.dart';
import 'package:home/home.dart';
import 'package:utils/utils.dart';
import 'package:checkout/checkout.dart';

class HomeRoutes {
  static Map<String, WidgetBuilder> routes = {
    RoutesPath.home: (context) => HomePage(),
    RoutesPath.product: (context) => ProductsPage(
          type: ModalRoute.of(context)?.settings.arguments is String
              ? ModalRoute.of(context)?.settings.arguments as String
              : null,
        ),
    RoutesPath.checkout: (context) => CheckoutPage(
        suggestionBuilder: (context) =>
            SuggestionList(type: ProductFilter.alsoBought)),
    RoutesPath.orderStatus: (context) => OrderPlacePage(
        order: ModalRoute.of(context)?.settings.arguments as Order),
  };
}
