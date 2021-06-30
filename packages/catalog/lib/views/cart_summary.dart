import 'package:business_logic/blocs/cart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:localize/generated/l10n.dart';
import 'package:uikit/uikit.dart';
import 'package:utils/utils.dart';

class CartSummaryCard extends StatelessWidget {
  const CartSummaryCard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: BlocBuilder<CartBloc, CartState>(
          buildWhen: (previous, current) => previous.carts != current.carts,
          builder: (context, state) {
            final amount = state.totalAmount;
            return amount > 0
                ? FloatingActionButton.extended(
                    shape: RoundedRectangleBorder(
                        side: BorderSide(
                            color: Theme.of(context).primaryColorDark),
                        borderRadius: BorderRadius.circular(24)),
                    elevation: 4,
                    backgroundColor: Theme.of(context).primaryColorLight,
                    foregroundColor: Theme.of(context).primaryColorDark,
                    onPressed: () =>
                        Navigator.of(context).pushNamed(RoutesPath.checkout),
                    label: Wrap(
                      crossAxisAlignment: WrapCrossAlignment.center,
                      children: [
                        Text(
                          "${S.of(context).n_item(state.totalItem)} . \$ ${amount.format()}",
                          style: AppTextSyle.extraBold().size16(),
                        ),
                        Container(
                          decoration: BoxDecoration(
                            border: Border(
                              left: BorderSide(
                                  color: Theme.of(context).primaryColorDark),
                            ),
                          ),
                          padding: EdgeInsets.only(left: 6),
                          margin: EdgeInsets.fromLTRB(8, 0, 0, 2),
                          child: Icon(Icons.shopping_bag),
                        )
                      ],
                    ),
                    heroTag: "checkout-button",
                  )
                : SizedBox();
          }),
    );
  }
}

class CartSummaryButton extends StatelessWidget {
  const CartSummaryButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CartBloc, CartState>(
        buildWhen: (previous, current) => previous.carts != current.carts,
        builder: (context, state) {
          final amount = state.totalAmount;
          return amount > 0
              ? FloatingActionButton.extended(
                  shape: RoundedRectangleBorder(
                      side:
                          BorderSide(color: Theme.of(context).primaryColorDark),
                      borderRadius: BorderRadius.circular(24)),
                  elevation: 4,
                  backgroundColor: Theme.of(context).primaryColorLight,
                  foregroundColor: Theme.of(context).primaryColorDark,
                  onPressed: () =>
                      Navigator.of(context).pushNamed(RoutesPath.checkout),
                  label: Wrap(
                    crossAxisAlignment: WrapCrossAlignment.center,
                    children: [
                      Text(
                        "${S.of(context).n_item(state.totalItem)} . \$ ${amount.format()}",
                        style: AppTextSyle.extraBold().size16(),
                      ),
                      Container(
                        decoration: BoxDecoration(
                          border: Border(
                            left: BorderSide(
                                color: Theme.of(context).primaryColorDark),
                          ),
                        ),
                        padding: EdgeInsets.only(left: 6),
                        margin: EdgeInsets.fromLTRB(8, 0, 0, 2),
                        child: Icon(Icons.shopping_bag),
                      )
                    ],
                  ),
                  heroTag: "checkout-button",
                )
              : SizedBox();
        });
  }
}
