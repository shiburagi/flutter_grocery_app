extension NumberFormmaterExt on num? {
  num get valueORZero => this ?? 0;
  String format() => valueORZero.toStringAsFixed(2);
}
