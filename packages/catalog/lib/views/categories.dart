import 'package:auto_animated/auto_animated.dart';
import 'package:business_logic/blocs/product.dart';
import 'package:business_logic/business_logic.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:utils/utils.dart';

final _options = LiveOptions(
  // Start animation after (default zero)
  delay: Duration(seconds: 0),

  // Show each item through (default 250)
  showItemInterval: Duration(milliseconds: 250),

  // Animation duration (default 250)
  showItemDuration: Duration(milliseconds: 500),

  // Animations starts at 0.05 visible
  // item fraction in sight (default 0.025)
  visibleFraction: 0.05,

  // Repeat the animation of the appearance
  // when scrolling in the opposite direction (default false)
  // To get the effect as in a showcase for ListView, set true
  reAnimateOnVisibility: false,
);

const _boxWidth = 100.0;
const _boxHeight = 130.0;

class CategoriesList extends StatefulWidget {
  const CategoriesList({Key? key, this.header}) : super(key: key);
  final Widget? header;
  @override
  _CategoriesListState createState() => _CategoriesListState();
}

class _CategoriesListState extends State<CategoriesList> {
  @override
  void initState() {
    context.read<ProductBloc>().retrieveCategories();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProductBloc, ProductState>(
        buildWhen: (previous, current) =>
            previous.categories != current.categories,
        builder: (context, state) {
          return state.categories?.isNotEmpty != true
              ? SizedBox()
              : Column(
                  children: [
                    widget.header ?? SizedBox(),
                    Container(
                      height: _boxHeight + 8,
                      child: LiveList.options(
                          padding: EdgeInsets.only(left: 12),
                          scrollDirection: Axis.horizontal,
                          itemBuilder: (context, index, animation) {
                            return buildAnimatedItem(
                                context, state.categories![index], animation);
                          },
                          itemCount: state.categories?.length ?? 0,
                          options: _options),
                    ),
                  ],
                );
        });
  }

  Widget buildAnimatedItem(
    BuildContext context,
    Category category,
    Animation<double> animation,
  ) =>
      FadeTransition(
        opacity: Tween<double>(
          begin: 0,
          end: 1,
        ).animate(animation),
        // And slide transition
        child: SlideTransition(
          position: Tween<Offset>(
            begin: Offset(0, -0.1),
            end: Offset.zero,
          ).animate(animation),
          // Paste you Widget
          child: CategoryView(
            category: category,
          ),
        ),
      );
}

class CategoryView extends StatelessWidget {
  const CategoryView({
    Key? key,
    required this.category,
  }) : super(key: key);
  final Category category;
  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 0,
      color: Theme.of(context).hintColor.withOpacity(0.04),
      margin: EdgeInsets.fromLTRB(4, 4, 4, 4),
      child: InkWell(
        onTap: () => Navigator.of(context)
            .pushNamed(RoutesPath.product, arguments: category.type),
        child: Container(
          height: _boxHeight,
          width: _boxWidth,
          child: Column(
            children: [
              Image.network(
                category.filename!,
                fit: BoxFit.cover,
                width: _boxWidth - 8,
                height: _boxWidth - 8,
                // height: _boxWidth,
              ),
              Container(
                padding: EdgeInsets.fromLTRB(8, 8, 8, 8),
                child: Column(
                  children: [Text(category.type!)],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
