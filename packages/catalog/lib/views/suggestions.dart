import 'package:auto_animated/auto_animated.dart';
import 'package:business_logic/business_logic.dart';
import 'package:catalog/views/product.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:utils/constants/contansts.dart';

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

const _boxWidth = 160.0;
const _boxWidthCompact = 200.0;
const _boxHeight = 210.0;
const _boxHeightCompact = 120.0;

class SuggestionList extends StatefulWidget {
  const SuggestionList({Key? key, this.header, required this.type})
      : super(key: key);
  final String type;
  final Widget? header;
  @override
  _SuggestionListState createState() => _SuggestionListState();
}

class _SuggestionListState extends State<SuggestionList> {
  @override
  void initState() {
    context.read<ProductBloc>().retrieveSuggestions(widget.type);
    super.initState();
  }

  bool get compact => widget.type == ProductFilter.alsoBought;
  double get height => compact ? _boxHeightCompact : _boxHeight;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProductBloc, ProductState>(
        buildWhen: (previous, current) =>
            previous.suggestions[widget.type] !=
            current.suggestions[widget.type],
        builder: (context, state) {
          final data = state.suggestions[widget.type] ?? [];
          return data.isEmpty
              ? SizedBox()
              : Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      child: widget.header,
                    ),
                    Container(
                      height: height + 8,
                      child: LiveList.options(
                          scrollDirection: Axis.horizontal,
                          itemBuilder: (context, index, animation) {
                            return buildAnimatedItem(
                                context, data[index], animation);
                          },
                          itemCount: data.length,
                          options: _options),
                    ),
                  ],
                );
        });
  }

  Widget buildAnimatedItem(
    BuildContext context,
    Product product,
    Animation<double> animation,
  ) {
    return FadeTransition(
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
        child: ProductView(
          compact: compact,
          width: compact ? _boxWidthCompact : _boxWidth,
          height: compact ? _boxHeightCompact : _boxHeight,
          product: product,
          type: widget.type,
        ),
      ),
    );
  }
}
