import 'package:auto_animated/auto_animated.dart';
import 'package:business_logic/blocs/product.dart';
import 'package:business_logic/business_logic.dart';
import 'package:catalog/views/product.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:uikit/uikit.dart';
import 'package:utils/utils.dart';

final _options = LiveOptions(
  delay: Duration(seconds: 0),
  showItemInterval: Duration(milliseconds: 50),
  showItemDuration: Duration(milliseconds: 150),
  visibleFraction: 0.05,
  reAnimateOnVisibility: false,
);

class ProductList extends StatefulWidget {
  const ProductList({Key? key, this.type, this.searchable = false})
      : super(key: key);

  final String? type;
  final bool searchable;
  @override
  _ProductListState createState() => _ProductListState();
}

class _ProductListState extends State<ProductList> {
  @override
  void initState() {
    if (widget.type == null || !ProductFilter.isBasicFilter(widget.type!))
      context.read<ProductBloc>().retrieveProduct();
    else
      context.read<ProductBloc>().retrieveSuggestions(widget.type!);

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 8),
      child: BlocBuilder<ProductBloc, ProductState>(builder: (context, state) {
        final products = widget.searchable
            ? state.getFilterProducts(widget.type)
            : state.getProducts(widget.type);
        final length = products?.length ?? 0;
        final mid = (length / 2).ceil();

        final list1 = products?.sublist(0, mid) ?? [];
        final list2 = products?.sublist(mid) ?? [];

        return Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            buildList(list1),
            buildList(list2),
          ],
        );
      }),
    );
  }

  Expanded buildList(List<Product> list) {
    return Expanded(
      child: LiveList.options(
          padding: EdgeInsets.zero,
          shrinkWrap: true,
          physics: NeverScrollableScrollPhysics(),
          scrollDirection: Axis.vertical,
          itemBuilder: (context, index, animation) {
            return buildAnimatedItem(context, list[index], animation);
          },
          itemCount: list.length,
          options: _options),
    );
  }

  Widget buildAnimatedItem(
    BuildContext context,
    Product product,
    Animation<double> animation,
  ) =>
      FadeAnimated(animation: animation, child: ProductView(product: product));
}
