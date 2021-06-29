import 'dart:convert';

import 'package:flutter/services.dart' show rootBundle;
import 'package:repositories/models/category.dart';
import 'package:repositories/models/product.dart';

class ProductRepo {
  static final ProductRepo instance = ProductRepo._();

  ProductRepo._();

  Future<List<Category>> getCategories() async {
    final data = await rootBundle.loadString('assets/json/categories.json');
    final json = jsonDecode(
      data,
      reviver: (key, value) {
        if (value is Map<String, dynamic>) {
          return Category.fromJson(value);
        }
        return value;
      },
    );
    return List.from(json);
  }

  Future<List<Product>> getProducts() async {
    final data = await rootBundle.loadString('assets/json/products.json');
    final json = jsonDecode(
      data,
      reviver: (key, value) {
        if (value is Map<String, dynamic>) {
          return Product.fromJson(value);
        }
        return value;
      },
    );
    return List.from(json);
  }

  Future<List<Product>> getSuggestion(String type) async {
    final data = await rootBundle.loadString('assets/json/$type.json');
    final json = jsonDecode(
      data,
      reviver: (key, value) {
        if (value is Map<String, dynamic>) {
          return Product.fromJson(value);
        }
        return value;
      },
    );
    return List.from(json);
  }
}
