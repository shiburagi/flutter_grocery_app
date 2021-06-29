import 'package:flutter/material.dart';
import 'package:uikit/components/shapes.dart';
import 'package:uikit/uikit.dart';

class LeafButton extends StatelessWidget {
  const LeafButton(
      {Key? key, this.child, this.backgroundColor, this.foregroundColor})
      : super(key: key);
  final Widget? child;
  final Color? backgroundColor;
  final Color? foregroundColor;
  @override
  Widget build(BuildContext context) {
    return Card(
      color: backgroundColor ?? Theme.of(context).primaryColorLight,
      elevation: 0,
      margin: EdgeInsets.zero,
      shape: LeafBorder(),
      child: DefaultTextStyle(
        style: (Theme.of(context).primaryTextTheme.button ??
                AppTextSyle.regular())
            .copyWith(
                color: foregroundColor ?? Theme.of(context).primaryColorDark),
        child: Container(
          padding: EdgeInsets.fromLTRB(16, 6, 16, 6),
          child: child,
        ),
      ),
    );
  }
}
