import 'package:flutter/material.dart';

const _radius = BorderRadius.only(
  topLeft: Radius.circular(8),
  bottomRight: Radius.circular(8),
);

class LeafBorder extends RoundedRectangleBorder {
  LeafBorder() : super(borderRadius: _radius);
}
