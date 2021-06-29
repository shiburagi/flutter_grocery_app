import 'package:flutter/material.dart';

ThemeData createTheme({String? fontFamily, Brightness? brightness}) {
  return ThemeData(
    brightness: brightness,
    fontFamily: fontFamily,
    primarySwatch: Colors.green,
    primaryColorDark: Colors.green.shade700,
    primaryColor: Color(0xff2ecc71),
    primaryColorLight: Colors.green.shade100,
  );
}

class AppTextSyle extends TextStyle {
  AppTextSyle.regular({double? height}) : super(height: height);
  AppTextSyle.light({double? height})
      : super(height: height, fontWeight: FontWeight.w200);
  AppTextSyle.semiLight({double? height})
      : super(height: height, fontWeight: FontWeight.w300);
  AppTextSyle.semiBold({double? height})
      : super(height: height, fontWeight: FontWeight.w600);
  AppTextSyle.bold({double? height})
      : super(height: height, fontWeight: FontWeight.bold);
  AppTextSyle.extraBold({double? height})
      : super(height: height, fontWeight: FontWeight.w800);
  AppTextSyle.black({double? height})
      : super(height: height, fontWeight: FontWeight.w900);
}

extension TextStyleExt on TextStyle {
  TextStyle size12() => copyWith(fontSize: 12);
  TextStyle size14() => copyWith(fontSize: 14);
  TextStyle size16() => copyWith(fontSize: 16);
  TextStyle size18() => copyWith(fontSize: 18);
  TextStyle size24() => copyWith(fontSize: 24);

  TextStyle colorHint(BuildContext context) =>
      copyWith(color: Theme.of(context).hintColor);
  TextStyle colorDisabled(BuildContext context) =>
      copyWith(color: Theme.of(context).disabledColor);
  TextStyle colorError(BuildContext context) =>
      copyWith(color: Theme.of(context).errorColor);
  TextStyle colorPrimary(BuildContext context) =>
      copyWith(color: Theme.of(context).primaryColor);
  TextStyle colorPrimaryDark(BuildContext context) =>
      copyWith(color: Theme.of(context).primaryColorDark);
}
