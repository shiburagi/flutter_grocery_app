import 'package:flutter/material.dart';

class PlainAppBar extends AppBar {}

class TransparentAppBar extends AppBar {
  TransparentAppBar({
    Widget? title,
    Widget? leading,
    Color? backgroundColor,
    double? titleSpacing,
    bool automaticallyImplyLeading = true,
    bool? centerTitle,
    List<Widget>? actions,
  }) : super(
          titleSpacing: titleSpacing,
          elevation: 0,
          actions: actions,
          leading: leading,
          centerTitle: centerTitle,
          automaticallyImplyLeading: automaticallyImplyLeading,
          backgroundColor: backgroundColor ?? Colors.transparent,
          title: title,
          iconTheme: IconThemeData(),
        );
}
