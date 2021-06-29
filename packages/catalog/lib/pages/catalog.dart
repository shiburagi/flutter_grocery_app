import 'package:auto_animated/auto_animated.dart';
import 'package:catalog/views/categories.dart';
import 'package:catalog/views/products.dart';
import 'package:catalog/views/suggestions.dart';
import 'package:flutter/material.dart';
import 'package:localize/generated/l10n.dart';
import 'package:uikit/uikit.dart';
import 'package:utils/utils.dart';

class CatalogPage extends StatefulWidget {
  CatalogPage({Key? key}) : super(key: key);

  @override
  _CatalogPageState createState() => _CatalogPageState();
}

class _CatalogPageState extends State<CatalogPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            buildSectionTitle(S.of(context).categories, onViewMore: () {}),
            CategoriesList(),
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
