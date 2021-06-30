import 'package:catalog/catalog.dart';
import 'package:catalog/views/categories.dart';
import 'package:catalog/views/products.dart';
import 'package:catalog/views/suggestions.dart';
import 'package:flutter/material.dart';
import 'package:localize/generated/l10n.dart';
import 'package:uikit/uikit.dart';
import 'package:utils/utils.dart';

class CatalogPage extends StatefulWidget {
  CatalogPage({Key? key, this.summaryBuilder}) : super(key: key);

  final WidgetBuilder? summaryBuilder;

  @override
  _CatalogPageState createState() => _CatalogPageState();
}

class _CatalogPageState extends State<CatalogPage> {
  bool get isMd => MediaQuery.of(context).size.width > 1000;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        margin: isMd ? EdgeInsets.symmetric(horizontal: 32) : null,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Flexible(
              child: SingleChildScrollView(
                child: buildMainContent(context),
              ),
            ),
            isMd
                ? Container(
                    margin: EdgeInsets.only(top: isMd ? 4 : 0),
                    child: widget.summaryBuilder?.call(context),
                  )
                : SizedBox(),
          ],
        ),
      ),
      floatingActionButton: isMd ? null : CartSummaryButton(),
    );
  }

  ConstrainedBox buildMainContent(BuildContext context) {
    return ConstrainedBox(
      constraints: BoxConstraints(maxWidth: 1000),
      child: Card(
        margin: EdgeInsets.fromLTRB(1, isMd ? 4 : 0, 1, 0),
        elevation: 4,
        color: Theme.of(context).cardColor,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            CategoriesList(
              header: buildSectionTitle(S.of(context).categories,
                  onViewMore: () {}),
            ),
            SuggestionList(
              header: buildSectionTitle(S.of(context).buyagain, onViewMore: () {
                Navigator.of(context).pushNamed(RoutesPath.product,
                    arguments: ProductFilter.buyAgain);
              }),
              type: ProductFilter.buyAgain,
            ),
            SuggestionList(
              header: buildSectionTitle(S.of(context).recommendforyou,
                  onViewMore: () {
                Navigator.of(context).pushNamed(RoutesPath.product,
                    arguments: ProductFilter.recommend);
              }),
              type: ProductFilter.recommend,
            ),
            buildSectionTitle(S.of(context).morechoice),
            ProductList(),
          ],
        ),
      ),
    );
  }

  Widget buildSectionTitle(String text, {VoidCallback? onViewMore}) =>
      Container(
        margin: EdgeInsets.fromLTRB(16, 24, 16, 8),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              text,
              style: AppTextSyle.semiBold().colorDisabled(context),
            ),
            Container(
              child: onViewMore == null
                  ? null
                  : InkWell(
                      onTap: onViewMore,
                      child: Text(
                        S.of(context).seeall,
                        style: AppTextSyle.regular().colorPrimary(context),
                      ),
                    ),
            )
          ],
        ),
      );
}
