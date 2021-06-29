import 'package:business_logic/blocs/cart.dart';
import 'package:business_logic/blocs/product.dart';
import 'package:business_logic/business_logic.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:localize/generated/l10n.dart';
import 'package:uikit/uikit.dart';
import 'package:utils/utils.dart';

class OrderPlacePage extends StatefulWidget {
  OrderPlacePage({Key? key, required this.order}) : super(key: key);
  final Order order;
  @override
  _OrderPlacePageState createState() => _OrderPlacePageState();
}

class _OrderPlacePageState extends State<OrderPlacePage> {
  bool get isConfirm => widget.order.status != "pending";
  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 0,
      margin: EdgeInsets.zero,
      child: BlocBuilder<CartBloc, CartState>(builder: (context, state) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TransparentAppBar(
              centerTitle: true,
              title: isConfirm
                  ? Card(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16),
                          side: BorderSide(
                              color: Theme.of(context).primaryColor)),
                      elevation: 2,
                      child: Container(
                        padding:
                            EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                        child: Text("20-40 minutes"),
                      ),
                    )
                  : Text("${S.of(context).requesting}..."),
              leading: IconButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  icon: Icon(Icons.clear)),
            ),
            Divider(),
            Center(
              child: isConfirm
                  ? Image.network(
                      widget.order.image,
                      height: 120,
                      width: 120,
                    )
                  : Container(
                      height: 60,
                      width: 60,
                      child: CircularProgressIndicator(
                        strokeWidth: 2,
                      ),
                    ),
            ),
            SizedBox(
              height: 16,
            ),
            isConfirm
                ? Container(
                    padding: EdgeInsets.fromLTRB(32, 8, 32, 8),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Text(
                          widget.order.title,
                          style: AppTextSyle.bold(),
                        ),
                        Text(
                          widget.order.message,
                          style: AppTextSyle.regular().colorHint(context),
                        ),
                      ],
                    ),
                  )
                : SizedBox(),
            Divider(),
            buildItems(context),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 16),
              child: isConfirm
                  ? OutlinedButton(
                      onPressed: () {},
                      child: Text(S.of(context).contactsupport.toUpperCase()),
                    )
                  : ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          primary: Theme.of(context).errorColor),
                      onPressed: () {
                        context.read<CartBloc>().cancelOrder(widget.order);
                        Navigator.of(context).pop(false);
                      },
                      child: Text(S.of(context).cancelorder.toUpperCase())),
            ),
            SizedBox(
              height: 8,
            ),
          ],
        );
      }),
    );
  }

  Container buildItems(BuildContext context) {
    return Container(
        padding: EdgeInsets.fromLTRB(32, 16, 32, 16),
        child: BlocBuilder<CartBloc, CartState>(
          builder: (context, state) {
            ProductBloc productBloc = context.read();
            final carts = widget.order.items;
            final fees = widget.order.fees;
            return Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text(
                  S.of(context).requesteditems,
                  style: AppTextSyle.bold(),
                ),
                ListView.builder(
                  shrinkWrap: true,
                  itemBuilder: (context, index) {
                    final cart = carts![index];
                    final product = productBloc.getProduct(cart.productId);

                    return Container(
                      child: Row(
                        children: [
                          Text("${cart.quantity}x"),
                          Expanded(child: Text(" ${product?.title ?? "-"}")),
                          Text(
                            "\$ ${(cart.quantity.valueORZero * cart.pricePerUnit.valueORZero).format()}",
                            style: AppTextSyle.semiBold(),
                          ),
                        ],
                      ),
                    );
                  },
                  itemCount: carts?.length ?? 0,
                ),
                Divider(
                  thickness: 1,
                ),
                ListView.builder(
                  shrinkWrap: true,
                  itemBuilder: (context, index) {
                    final fee = fees![index];

                    return Container(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text("${fee.label}"),
                          Text(
                            "\$ ${fee.actualAmount(carts?.totalAmount ?? 0).format()}",
                            style: AppTextSyle.semiBold(),
                          ),
                        ],
                      ),
                    );
                  },
                  itemCount: fees?.length ?? 0,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(S.of(context).totalamount),
                    Text(
                      "\$ ${carts?.totalAmount.format()}",
                      style: AppTextSyle.black(),
                    ),
                  ],
                ),
              ],
            );
          },
        ));
  }
}
