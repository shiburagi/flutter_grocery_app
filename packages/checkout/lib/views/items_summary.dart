import 'package:auto_animated/auto_animated.dart';
import 'package:business_logic/blocs/cart.dart';
import 'package:checkout/checkout.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:localize/generated/l10n.dart';
import 'package:uikit/uikit.dart';
import 'package:utils/utils.dart';

final _options = LiveOptions(
  delay: Duration(seconds: 0),
  showItemInterval: Duration(milliseconds: 50),
  showItemDuration: Duration(milliseconds: 150),
  visibleFraction: 0.05,
  reAnimateOnVisibility: false,
);

class ItemsSummary extends StatefulWidget {
  const ItemsSummary({Key? key, this.suggestionWidget}) : super(key: key);
  final Widget? suggestionWidget;

  @override
  _ItemsSummaryState createState() => _ItemsSummaryState();
}

class _ItemsSummaryState extends State<ItemsSummary> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CartBloc, CartState>(
      builder: (context, state) {
        return Hero(
          tag: "items-summary-container",
          child: Card(
            margin: EdgeInsets.zero,
            elevation: 0,
            child: buildProductList(state),
          ),
        );
      },
    );
  }

  List<CheckoutStateWidgetBuilder> productListWidgets() => [
        (state) => widget.suggestionWidget ?? SizedBox(),
        (state) => buildVoucher(state),
        (state) => buildTotalAmount(state),
      ];

  Widget buildProductList(CartState state) {
    final widgets = productListWidgets();
    return state.carts.isNotEmpty
        ? LiveList.options(
            physics: NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            itemBuilder: (context, index, animation) {
              final widget = index < state.carts.length
                  ? RequestedItemView(
                      cart: state.carts[index],
                    )
                  : widgets[index - state.carts.length](state);
              return context.isMd
                  ? widget
                  : FadeAnimated(
                      animation: animation,
                      child: widget,
                    );
            },
            itemCount: state.carts.length + widgets.length,
            options: _options)
        : Container(
            child: Center(
              child: Text(
                S.of(context).yourbasketisempty,
                style: AppTextSyle.regular().colorDisabled(context),
              ),
            ),
          );
  }

  Container buildVoucher(CartState state) => Container(
        margin: EdgeInsets.symmetric(horizontal: 16),
        padding: EdgeInsets.fromLTRB(8, 16, 4, 0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Expanded(
                  child: Text(
                    S.of(context).voucher,
                    style: AppTextSyle.regular().size14(),
                  ),
                ),
                SizedBox(
                  width: 8,
                ),
                Expanded(
                    flex: 2,
                    child: TextField(
                      readOnly: true,
                      decoration: InputDecoration(
                        isDense: true,
                        filled: true,
                        contentPadding: EdgeInsets.fromLTRB(8, 4, 8, 4),
                        border: OutlineInputBorder(),
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: Theme.of(context).disabledColor,
                            width: 0.5,
                          ),
                        ),
                      ),
                    )),
              ],
            ),
          ],
        ),
      );

  Widget buildTotalAmount(CartState state) {
    final totalAmount = state.totalAmount;
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 16),
      padding: EdgeInsets.symmetric(horizontal: 8, vertical: 16),
      child: Column(
        children: [
          Divider(
            height: 1,
          ),
          SizedBox(
            height: 16,
          ),
          ...state.fees?.map((e) {
                return buildAmount(e.label, e.actualAmount(totalAmount));
              }) ??
              [],
          buildAmount(S.of(context).totalamount, state.totalAmount,
              style: AppTextSyle.black()),
        ],
      ),
    );
  }

  Row buildAmount(String label, double amount, {TextStyle? style}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(
          label,
          style: AppTextSyle.semiBold().size14(),
        ),
        Text(
          "\$ ${amount.format()}",
          style: AppTextSyle.bold().size14().merge(style),
        ),
      ],
    );
  }
}

class ItemsSummaryCard extends StatelessWidget {
  const ItemsSummaryCard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      margin: EdgeInsets.fromLTRB(32, 0, 0, 0),
      child: ConstrainedBox(
        constraints: BoxConstraints(maxWidth: 300),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          // mainAxisAlignment: MainAxisAlignment.spaceBetween,
          mainAxisSize: MainAxisSize.min,
          children: [
            CheckoutTitle(title: S.of(context).yourbasket),
            Divider(
              height: 1,
            ),
            ConstrainedBox(
                constraints: BoxConstraints(minHeight: 200),
                child: ItemsSummary()),
            Container(
              margin: EdgeInsets.fromLTRB(16, 8, 16, 8),
              child:
                  BlocBuilder<CartBloc, CartState>(builder: (context, state) {
                return Hero(
                  tag: "checkout-button",
                  child: ElevatedButton(
                      onPressed: state.carts.isEmpty
                          ? null
                          : () => Navigator.of(context)
                              .pushNamed(RoutesPath.checkout),
                      child: Text(S.of(context).checkout.toUpperCase())),
                );
              }),
            )
          ],
        ),
      ),
    );
  }
}
