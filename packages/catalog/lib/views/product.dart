import 'package:business_logic/business_logic.dart';
import 'package:catalog/pages/product_add.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:localize/generated/l10n.dart';
import 'package:uikit/uikit.dart';
import 'package:utils/utils.dart';

class ProductView extends StatelessWidget {
  const ProductView({
    Key? key,
    this.compact = false,
    this.width,
    this.height,
    this.type,
    required this.product,
  })  : _imageHeight = compact ? 60 : 120,
        super(key: key);
  final double? width;
  final double? height;
  final bool compact;
  final String? type;
  final Product product;
  final double _imageHeight;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => showPageAsBottomSheet(context,
          builder: (context) => ProductAddPage(
                product: product,
              )),
      child: Card(
        clipBehavior: Clip.antiAlias,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        margin: EdgeInsets.fromLTRB(8, 4, 4, 4),
        child: Container(
          width: width,
          height: height,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Stack(
                children: [
                  Positioned.fill(
                    bottom: 10,
                    child: buildImage(context),
                  ),
                  Positioned(
                    top: _imageHeight - 30,
                    left: 0,
                    right: 0,
                    child: buildGradient(context),
                  ),
                  Container(
                    margin: EdgeInsets.only(top: _imageHeight - 10),
                    padding: EdgeInsets.fromLTRB(0, 8, 0, compact ? 0 : 12),
                    color: Theme.of(context).cardColor,
                    child: buildProductDetail(),
                  ),
                  Positioned(
                    right: 4,
                    top: _imageHeight - 30,
                    child: buildFavourite(),
                  ),
                ],
              ),
              buildBottomBar(context),
            ],
          ),
        ),
      ),
    );
  }

  Container buildBottomBar(BuildContext context) {
    return Container(
      color: Theme.of(context).dividerColor.withOpacity(0.05),
      padding: EdgeInsets.only(left: 16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            "\$ ${product.price.format()}",
            style: AppTextSyle.black(),
          ),
          BlocBuilder<CartBloc, CartState>(buildWhen: (previous, current) {
            return previous.getCart(product) != current.getCart(product);
          }, builder: (context, state) {
            final cart = state.getCart(product);
            bool isUpdate = (cart.quantity ?? 0) > 0;
            return LeafButton(
              backgroundColor: isUpdate ? Colors.yellow.shade100 : null,
              foregroundColor: isUpdate ? Colors.yellow.shade900 : null,
              child: Text(isUpdate
                  ? "x${cart.quantity.valueORZero}"
                  : S.of(context).add),
            );
          }),
        ],
      ),
    );
  }

  Card buildFavourite() {
    return Card(
      elevation: 1,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      child: Container(
        padding: EdgeInsets.all(6),
        child: Icon(Icons.favorite_border, color: Colors.red.shade200),
      ),
    );
  }

  Container buildGradient(BuildContext context) {
    return Container(
      height: 30,
      decoration: BoxDecoration(
          gradient: LinearGradient(
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
        colors: [
          Colors.transparent,
          Theme.of(context).cardColor.withOpacity(0.4),
          Theme.of(context).cardColor,
        ],
        stops: [0, 0.5, 0.9],
      )),
    );
  }

  Container buildImage(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width / 2,
      color: Theme.of(context).cardColor,
      child: product.filename == null
          ? null
          : Image.network(
              product.filename!,
              height: _imageHeight,
              fit: BoxFit.cover,
            ),
    );
  }

  Column buildProductDetail() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Container(
          padding: EdgeInsets.only(right: 48, left: 12),
          child: Text(
            product.title ?? "-",
            maxLines: height != null ? 1 : null,
            overflow: height != null ? TextOverflow.ellipsis : null,
          ),
        ),
        compact
            ? SizedBox()
            : Align(
                alignment: Alignment.centerLeft,
                child: Card(
                  margin: EdgeInsets.only(left: 12, top: 4),
                  elevation: 0,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10)),
                  color: Colors.blue.shade100,
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 8),
                    child: Text(
                      product.type ?? "-",
                      style: AppTextSyle.semiBold()
                          .copyWith(color: Colors.blue.shade800),
                    ),
                  ),
                ),
              )
      ],
    );
  }
}
