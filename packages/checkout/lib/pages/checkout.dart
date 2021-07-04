import 'dart:math';

import 'package:auto_animated/auto_animated.dart';
import 'package:business_logic/blocs/cart.dart';
import 'package:business_logic/business_logic.dart';
import 'package:checkout/pages/order_placed.dart';
import 'package:checkout/views/items_summary.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:localize/generated/l10n.dart';
import 'package:uikit/uikit.dart';
import 'package:user_info/views/delivery_location.dart';
import 'package:utils/utils.dart';

final _options = LiveOptions(
  delay: Duration(seconds: 0),
  showItemInterval: Duration(milliseconds: 50),
  showItemDuration: Duration(milliseconds: 150),
  visibleFraction: 0.05,
  reAnimateOnVisibility: false,
);

typedef CheckoutStateWidgetBuilder = Widget Function(CartState);

class CheckoutPage extends StatefulWidget {
  CheckoutPage({Key? key, this.suggestionBuilder}) : super(key: key);
  final WidgetBuilder? suggestionBuilder;
  @override
  _CheckoutPageState createState() => _CheckoutPageState();
}

class _CheckoutPageState extends State<CheckoutPage> {
  @override
  void initState() {
    context.read<PaymentBloc>().retrieveOptions();
    super.initState();
  }

  handleCheckout() async {
    final order = await context.read<CartBloc>().sendOrder();
    final result = await showPageAsBottomSheet(context, builder: (context) {
      return OrderPlacePage(order: order);
    });
    if (result != false) {
      context.read<CartBloc>().clearCart();
      Navigator.of(context).popUntil((r) => r.isFirst);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        child: Container(
          decoration: BoxDecoration(
              border: Border(
                  bottom: BorderSide(color: Theme.of(context).dividerColor))),
          child: TransparentAppBar(
            backgroundColor: Theme.of(context).cardColor,
            titleSpacing: 0,
            title: DeliveryLocation(),
          ),
        ),
        preferredSize: Size.fromHeight(kToolbarHeight),
      ),
      body: Align(
        alignment: Alignment.topCenter,
        child: ConstrainedBox(
          constraints: BoxConstraints(maxWidth: 1000),
          child: SingleChildScrollView(
            child: Card(
              margin: EdgeInsets.zero,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.zero),
              child:
                  BlocBuilder<CartBloc, CartState>(builder: (context, state) {
                return state.carts.isEmpty
                    ? Container(
                        alignment: Alignment.center,
                        child: Text(
                          S.of(context).emptycart_msg,
                          style: AppTextSyle.semiBold().colorDisabled(context),
                        ),
                      )
                    : Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          CheckoutTitle(title: S.of(context).requesteditems),
                          ItemsSummary(
                            suggestionWidget:
                                widget.suggestionBuilder?.call(context),
                          ),
                          Divider(
                            thickness: 2,
                          ),
                          CheckoutTitle(title: S.of(context).paymentdetails),
                          buildPaymentOption(),
                          SizedBox(
                            height: 32,
                          )
                        ],
                      );
              }),
            ),
          ),
        ),
      ),
      persistentFooterButtons: [
        Center(
          child: BlocBuilder<CartBloc, CartState>(
              buildWhen: (previous, current) =>
                  previous.totalAmount != current.totalAmount,
              builder: (context, state) {
                return Hero(
                  tag: "checkout-button",
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        minimumSize: Size(
                            min(MediaQuery.of(context).size.width, 980), 48)),
                    child: Text((state.carts.isEmpty
                            ? S.of(context).back
                            : S.of(context).pay)
                        .toUpperCase()),
                    onPressed: state.totalAmount > 0
                        ? handleCheckout
                        : () => Navigator.of(context).pop(),
                  ),
                );
              }),
        ),
      ],
    );
  }

  Widget buildPaymentOption() {
    return Container(
      height: 80,
      child: BlocBuilder<PaymentBloc, PaymentState>(builder: (context, state) {
        List<PaymentOption>? options = state.seletedPayment == null
            ? state.options
            : ([state.seletedPayment!]..addAll(state.options?.where((element) =>
                    element.cardNo != state.seletedPayment?.cardNo) ??
                []));
        return LiveList.options(
            padding: EdgeInsets.only(left: 16),
            shrinkWrap: true,
            scrollDirection: Axis.horizontal,
            itemBuilder: (context, index, animation) {
              final option = options![index];
              return FadeAnimated(
                  animation: animation,
                  child: PaymentOptionView(
                    option: option,
                    selected: option.cardNo == state.seletedPayment?.cardNo,
                  ));
            },
            itemCount: options?.length ?? 0,
            options: _options);
      }),
    );
  }
}

class PaymentOptionView extends StatelessWidget {
  const PaymentOptionView({
    Key? key,
    required this.option,
    this.selected = false,
  }) : super(key: key);
  final PaymentOption option;
  final bool selected;

  String get image {
    switch (option.type) {
      case "visa":
        return "https://cdn2.iconfinder.com/data/icons/social-media-and-payment/64/-69-256.png";
      case "mastercard":
        return "https://cdn2.iconfinder.com/data/icons/bitsies/128/Mastercard-256.png";
      case "amex":
        return "https://cdn3.iconfinder.com/data/icons/payment-method-1/64/_American_Express-256.png";

      default:
        return "";
    }
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => context.read<PaymentBloc>().setPayment(option),
      child: Card(
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
            side: BorderSide(
                color: selected
                    ? Theme.of(context).primaryColor
                    : Theme.of(context).dividerColor)),
        elevation: 2,
        clipBehavior: Clip.antiAliasWithSaveLayer,
        child: Container(
          color:
              selected ? Theme.of(context).primaryColor.withOpacity(0.1) : null,
          width: 160,
          padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                option.name ?? "",
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    option.cardNo ?? "",
                    style: AppTextSyle.bold(),
                  ),
                  Image.network(
                    image,
                    height: 32,
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}

class RequestedItemView extends StatefulWidget {
  const RequestedItemView({
    Key? key,
    required this.cart,
  }) : super(key: key);

  final Cart cart;

  @override
  _RequestedItemViewState createState() => _RequestedItemViewState();
}

class _RequestedItemViewState extends State<RequestedItemView> {
  Product? get product =>
      context.read<ProductBloc>().getProduct(widget.cart.productId);
  addQuatity(BuildContext context, int value) {
    final nextValue = widget.cart.quantity.valueORZero.toInt() + value;
    if (nextValue > 0) {
      widget.cart.quantity = nextValue;
      context.read<CartBloc>().refreshCart();
    } else {
      final state = Slidable.of(context);
      state?.open(actionType: SlideActionType.primary);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Slidable(
      actionPane: SlidableDrawerActionPane(),
      actionExtentRatio: 0.25,
      child: Builder(builder: (context) => buildDetail(context)),
      actions: [
        IconSlideAction(
          caption: S.of(context).remove,
          color: Theme.of(context).errorColor,
          icon: Icons.delete,
          onTap: () => context.read<CartBloc>().removeItem(widget.cart),
        ),
        IconSlideAction(
          caption: S.of(context).cancel,
          color: Theme.of(context).disabledColor,
          icon: Icons.clear,
          onTap: () => Slidable.of(context)?.close(),
        ),
      ],
    );
  }

  Widget buildDetail(BuildContext context) {
    final product = this.product;
    final price = product?.price ?? 0;
    final amount = price * widget.cart.quantity.valueORZero;
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 16),
      decoration: BoxDecoration(
          border: Border(
              bottom: BorderSide(
                  color: Theme.of(context).dividerColor, width: 0.5))),
      padding: EdgeInsets.symmetric(horizontal: 8, vertical: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(product?.title ?? "-"),
          SizedBox(
            height: 8,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              buildCountCountrol(context),
              Text(
                "\$ ${amount.format()}",
                style: AppTextSyle.semiBold().size14(),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Card buildCountCountrol(BuildContext context) {
    return Card(
      margin: EdgeInsets.zero,
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(4),
          side: BorderSide(color: Theme.of(context).dividerColor, width: 0.5)),
      child: IntrinsicHeight(
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            buidCounControlButton(
              Icons.remove,
              onPressed: () => addQuatity(context, -1),
            ),
            Container(
                alignment: Alignment.center,
                padding: EdgeInsets.symmetric(horizontal: 8),
                decoration: BoxDecoration(
                    border: Border.symmetric(
                        vertical:
                            BorderSide(color: Theme.of(context).dividerColor))),
                child: Text(
                  "x ${widget.cart.quantity}",
                )),
            buidCounControlButton(
              Icons.add,
              onPressed: () => addQuatity(context, 1),
            ),
          ],
        ),
      ),
    );
  }

  Widget buidCounControlButton(IconData icon, {VoidCallback? onPressed}) {
    return InkWell(
      onTap: onPressed,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 8, vertical: 8),
        child: Icon(
          icon,
          size: 12,
        ),
      ),
    );
  }
}

class CheckoutTitle extends StatelessWidget {
  const CheckoutTitle({Key? key, required this.title}) : super(key: key);
  final String title;

  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.fromLTRB(16, 8, 16, 8),
      child: Text(
        title,
        style: AppTextSyle.semiBold().colorPrimaryDark(context),
      ),
    );
  }
}
