import 'package:business_logic/blocs/cart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:uikit/uikit.dart';
import 'package:utils/utils.dart';

class OrderStatusView extends StatelessWidget {
  const OrderStatusView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CartBloc, CartState>(
      buildWhen: (previous, current) => previous.orders != current.orders,
      builder: (context, state) {
        final order = state.imcompleteOrder;
        return state.hasImcompleteOrder == true
            ? InkWell(
                onTap: () => Navigator.of(context).pushNamed(
                    RoutesPath.orderStatus,
                    arguments: state.imcompleteOrder),
                child: Container(
                  decoration: BoxDecoration(
                      border: Border(
                    top: BorderSide(
                        color: Theme.of(context).dividerColor, width: 0.5),
                  )),
                  padding: EdgeInsets.all(16),
                  child: Row(
                    children: [
                      Image.network(
                        order?.image ?? "",
                        width: 48,
                      ),
                      SizedBox(
                        width: 16,
                      ),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(order?.title ?? "-"),
                            Text(
                              order?.message ?? "-",
                              style: AppTextSyle.regular().colorHint(context),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        width: 16,
                      ),
                      Icon(Icons.expand_less)
                    ],
                  ),
                ),
              )
            : SizedBox();
      },
    );
  }
}
