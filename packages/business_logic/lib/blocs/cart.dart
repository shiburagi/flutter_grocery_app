import 'dart:math';

import 'package:bloc/bloc.dart';
import 'package:business_logic/business_logic.dart';
import 'package:localize/generated/l10n.dart';
import 'package:utils/utils.dart';

typedef TypeComparator<T> = bool Function(T);

TypeComparator<Cart> findCartEqual(int? productId) {
  return (element) => element.productId == productId;
}

TypeComparator<Cart> findCartNoEqual(int? productId) {
  return (element) => element.productId != productId;
}

class CartBloc extends Cubit<CartState> {
  CartBloc() : super(CartState()) {
    emit(state.copyWith(fees: fees));
  }
  Cart getCart(Product product) => state.getCart(product);
  double get totalAmount => state.carts.totalAmount;
  int get totalItem => state.carts.totalItem;

  addItem(Cart cart) {
    emit(state.copyWith(
        carts: state.carts.where(findCartNoEqual(cart.productId)).toList()
          ..add(cart)));
  }

  refreshCart() {
    emit(state.copyWith(carts: state.carts.toList()));
  }

  void removeItem(Cart cart) {
    emit(state.copyWith(
        carts: state.carts.where(findCartNoEqual(cart.productId)).toList()));
  }

  void clearCart() {
    emit(state.copyWith(carts: []));
  }

  Future<Order> sendOrder() async {
    Order order = Order(
      createdMillis: DateTime.now().millisecondsSinceEpoch,
      fees: state.fees,
      items: state.carts,
      userId: "001",
      status: "pending",
      refId: "REF${Random().nextInt(100000)}",
    );
    emit(state.copyWith(orders: [...state.orders ?? [], order]));

    Future.delayed(Duration(seconds: 5), () {
      order.status = "preparing";
      emit(state.copyWith(orders: [...state.orders ?? []]));
    });
    Future.delayed(Duration(seconds: 15), () {
      order.status = "collected";
      emit(state.copyWith(orders: [...state.orders ?? []]));
    });
    Future.delayed(Duration(seconds: 25), () {
      order.status = "delivered";
      emit(state.copyWith(orders: [...state.orders ?? []]));
    });

    return order;
  }

  void cancelOrder(Order order) {
    emit(state.copyWith(
        orders: state.orders
            ?.where((element) => element.refId != order.refId)
            .toList()));
  }
}

final List<Fees> fees = [
  Fees(
    name: "Delivery fee",
    amount: 5.0,
  ),
  Fees(
    name: "Service tax",
    percent: 0.05,
  ),
];

class CartState {
  final List<Cart> carts;
  final List<Fees>? fees;
  final List<Order>? orders;

  CartState({
    this.carts = const [],
    this.orders,
    this.fees,
  });

  int get totalItem => carts.totalItem;
  double get totalAmount => carts.totalAmount;
  Order? get imcompleteOrder {
    try {
      return orders?.lastWhere((element) => element.status != "delivered");
    } catch (e) {
      return null;
    }
  }

  bool get hasImcompleteOrder => imcompleteOrder != null;

  String get estimateDuration =>
      imcompleteOrder?.estimateDuration ?? S.current.completed;

  Cart getCart(Product product) {
    final productId = product.productId;
    final price = product.price;
    return carts.firstWhere(findCartEqual(productId),
        orElse: () => Cart(productId: productId, pricePerUnit: price));
  }

  CartState copyWith({
    List<Cart>? carts,
    List<Fees>? fees,
    List<Order>? orders,
  }) =>
      CartState(
        carts: carts ?? this.carts,
        orders: orders ?? this.orders,
        fees: fees ?? this.fees,
      );
}

extension FeeListExtension on List<Fees> {
  double get totalFee => this.fold<double>(
      0.0, (value, element) => value + element.amount.valueORZero);
}

extension CartListExtension on List<Cart> {
  double get totalAmount => this.fold<double>(
      0.0,
      (value, element) =>
          value +
          element.pricePerUnit.valueORZero * element.quantity.valueORZero);

  int get totalItem => this.fold<int>(
      0, (value, element) => value + element.quantity.valueORZero.toInt());
}

extension FeeExt on Fees {
  String get label =>
      "${this.name} ${this.percent == null ? "" : "(${(this.percent.valueORZero * 100).toInt()}%)"}";
  double actualAmount(double totalAmount) => this.percent == null
      ? this.amount.valueORZero.toDouble()
      : totalAmount * this.percent.valueORZero;
}

extension OrderExt on Order {
  String get title {
    switch (status) {
      case "collected":
        return S.current.ordercollected;
      case "delivered":
        return S.current.orderdelivered;
      default:
        return S.current.orderplaced;
    }
  }

  String get message {
    switch (status) {
      case "collected":
        return S.current.ordercollected_msg;
      case "delivered":
        return S.current.orderdelivered_msg;
      default:
        return S.current.orderplaced_msg;
    }
  }

  String get estimateDuration {
    switch (status) {
      case "collected":
        return "5-10 minutes";
      case "delivered":
        return S.current.completed;
      default:
        return "30-40 minutes";
    }
  }

  String get image {
    switch (status) {
      case "collected":
        return "https://cdn3.iconfinder.com/data/icons/street-food-and-food-trucker-1/64/fruit-car-street-sell-delivery-256.png";
      case "delivered":
        return "https://cdn3.iconfinder.com/data/icons/strokeline/128/revisi_05-512.png";
      default:
        return "https://cdn4.iconfinder.com/data/icons/delivery-121/62/food-delivery-service-restaurant-order-256.png";
    }
  }
}
