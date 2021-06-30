import 'package:flutter/material.dart';
import 'package:skeleton_text/skeleton_text.dart';

class SkeletonContainer extends StatelessWidget {
  const SkeletonContainer({Key? key, this.width}) : super(key: key);
  final double? width;

  @override
  Widget build(BuildContext context) {
    return SkeletonAnimation(
      shimmerColor: Theme.of(context).disabledColor.withOpacity(0.1),
      shimmerDuration: 1000,
      child: Container(
        width: width,
        color: Theme.of(context).disabledColor.withOpacity(0.1),
      ),
    );
  }
}

class SkeletonText extends StatelessWidget {
  const SkeletonText({Key? key, this.width = 40}) : super(key: key);

  final double width;

  @override
  Widget build(BuildContext context) {
    return SkeletonAnimation(
      shimmerColor: Theme.of(context).disabledColor.withOpacity(0.1),
      shimmerDuration: 1000,
      child: Container(
        width: width,
        color: Theme.of(context).disabledColor.withOpacity(0.1),
        child: Text(""),
      ),
    );
  }
}
