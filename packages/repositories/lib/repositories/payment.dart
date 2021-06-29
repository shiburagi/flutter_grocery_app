import 'dart:convert';

import 'package:flutter/services.dart' show rootBundle;
import 'package:repositories/repositories.dart';

class PaymemtRepo {
  static final PaymemtRepo instance = PaymemtRepo._();

  PaymemtRepo._();

  Future<List<PaymentOption>> getOptions() async {
    final data = await rootBundle.loadString('assets/json/paymentOptions.json');
    final json = jsonDecode(
      data,
      reviver: (key, value) {
        if (value is Map<String, dynamic>) {
          return PaymentOption.fromJson(value);
        }
        return value;
      },
    );
    return List.from(json);
  }
}
