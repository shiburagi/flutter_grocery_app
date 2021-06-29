import 'package:flutter/material.dart';
import 'package:localize/generated/l10n.dart';
import 'package:uikit/uikit.dart';

class SearchBar extends StatelessWidget {
  const SearchBar(
      {Key? key, this.autofocus = false, this.onChanged, this.focusNode})
      : super(key: key);

  final bool autofocus;
  final ValueChanged<String>? onChanged;
  final FocusNode? focusNode;
  Widget build(BuildContext context) {
    final border =
        OutlineInputBorder(borderSide: BorderSide(color: Colors.transparent));
    return Hero(
      tag: "search-bar",
      child: Card(
        child: TextField(
          focusNode: focusNode,
          cursorColor: Theme.of(context).hintColor,
          cursorWidth: 1,
          onChanged: onChanged,
          autofocus: autofocus,
          decoration: InputDecoration(
            filled: true,
            isDense: true,
            contentPadding: EdgeInsets.fromLTRB(16, 12, 0, 11),
            prefixIcon: Container(
              padding: EdgeInsets.only(right: 4),
              alignment: Alignment.centerRight,
              child: Icon(
                Icons.search,
                color: Theme.of(context).disabledColor,
              ),
            ),
            isCollapsed: true,
            prefixIconConstraints: BoxConstraints.expand(height: 32, width: 40),
            border: border,
            enabledBorder: border,
            hintText: S.of(context).search,
            hintStyle: AppTextSyle.regular().colorDisabled(context),
            focusedBorder: border.copyWith(borderSide: BorderSide(width: 0.5)),
          ),
        ),
      ),
    );
  }
}
