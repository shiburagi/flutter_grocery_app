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

        bool isLoad = products == null;
        return LayoutBuilder(builder: (context, constraints) {
          final column = (constraints.maxWidth / 160).floor();
          return Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: List.generate(
                column,
                (index) => isLoad
                    ? buildSkeletonList()
                    : buildList(products, index, column)),
          );
        });
      }),
    );
  }

  Widget buildSkeletonList() {
    return Expanded(
      child: ListView.builder(
        padding: EdgeInsets.zero,
        shrinkWrap: true,
        physics: NeverScrollableScrollPhysics(),
        scrollDirection: Axis.vertical,
        itemBuilder: (context, index) {
          return SkeletonProductView();
        },
        itemCount: 1,
      ),
    );
  }

  Widget buildList(List<Product> list, int slotId, int column) {
    int length = (list.length / column).floor();

    int balance = list.isNotEmpty ? list.length % length : 0;

    if (slotId < balance) length++;
    return Expanded(
      child: LiveList.options(
          padding: EdgeInsets.zero,
          shrinkWrap: true,
          physics: NeverScrollableScrollPhysics(),
          scrollDirection: Axis.vertical,
          itemBuilder: (context, index, animation) {
            int i = index * column + slotId;
            return buildAnimatedItem(context, list[i], animation);
          },
          itemCount: length,
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
