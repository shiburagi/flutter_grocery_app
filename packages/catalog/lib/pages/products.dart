import 'package:business_logic/blocs/product.dart';
import 'package:catalog/views/cart_summary.dart';
import 'package:catalog/views/products.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:localize/generated/l10n.dart';
import 'package:uikit/components/textfield.dart';
import 'package:uikit/uikit.dart';
import 'package:utils/utils.dart';

class ProductsPage extends StatefulWidget {
  const ProductsPage({Key? key, this.type, this.summaryBuilder})
      : super(key: key);
  final String? type;
  final WidgetBuilder? summaryBuilder;

  @override
  _ProductsPageState createState() => _ProductsPageState();
}

class _ProductsPageState extends State<ProductsPage> {
  bool expand = false;
  final FocusNode _focusNode = FocusNode();
  StateSetter? setter;
  @override
  void initState() {
    expand = widget.type == ProductFilter.search;
    context.read<ProductBloc>().filter("");
    if (widget.type != ProductFilter.search)
      _focusNode.addListener(() {
        if (expand && !_focusNode.hasFocus) {
          Future.delayed(Duration(milliseconds: 500), () {
            setter?.call(() {
              expand = false;
            });
          });
        }
      });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: Scaffold(
        appBar: TransparentAppBar(
          titleSpacing: 0,
          title: buildAppbarTitle(context),
        ),
        body: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Flexible(
              child: SingleChildScrollView(
                physics: BouncingScrollPhysics(),
                child: ProductList(
                  searchable: true,
                  type: widget.type == "search" ? null : widget.type,
                ),
              ),
            ),
            Visibility(
              visible: context.isMd,
              child: Container(
                margin: EdgeInsets.only(top: 4, right: 16),
                child: widget.summaryBuilder?.call(context),
              ),
            )
          ],
        ),
        floatingActionButton: context.isMd ? null : CartSummaryButton(),
      ),
    );
  }

  String get title {
    switch (widget.type) {
      case ProductFilter.buyAgain:
        return S.current.buyagain;
      case ProductFilter.recommend:
        return S.current.recommendforyou;
      default:
        return widget.type ?? "";
    }
  }

  Widget buildAppbarTitle(BuildContext context) {
    return StatefulBuilder(builder: (context, setState) {
      setter = setState;
      return Container(
        margin: EdgeInsets.only(right: 8, left: 0),
        height: kToolbarHeight,
        child: Stack(
          alignment: Alignment.centerLeft,
          children: [
            Container(
              padding: EdgeInsets.only(left: 8, right: 8),
              child: Row(
                children: [
                  Expanded(
                    child: Text(
                      title,
                      style: TextStyle(
                          color: Theme.of(context).hintColor.withOpacity(1)),
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      Future.delayed(Duration(milliseconds: 300), () {
                        FocusScope.of(context).requestFocus(_focusNode);
                      });
                      setState(() {
                        expand = true;
                      });
                    },
                    child: Chip(
                      label: Text(S.of(context).search),
                      avatar: Icon(Icons.search),
                    ),
                  ),
                ],
              ),
            ),
            Container(
              width: MediaQuery.of(context).size.width,
              child: HorizontalExpand(
                width: MediaQuery.of(context).size.width,
                expand: expand,
                child: SearchBar(
                  focusNode:
                      widget.type == ProductFilter.search ? null : _focusNode,
                  onChanged: (value) =>
                      context.read<ProductBloc>().filter(value),
                  autofocus: widget.type == "search",
                ),
              ),
            ),
          ],
        ),
      );
    });
  }
}
