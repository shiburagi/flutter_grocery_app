import 'package:flutter/material.dart';

class FadeAnimated extends StatelessWidget {
  const FadeAnimated({
    Key? key,
    required this.animation,
    required this.child,
  }) : super(key: key);

  final Widget child;
  final Animation<double> animation;
  @override
  Widget build(BuildContext context) {
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
        child: child,
      ),
    );
  }
}

class HorizontalExpand extends StatefulWidget {
  HorizontalExpand(
      {Key? key, required this.child, required this.width, this.expand = false})
      : super(key: key);
  final Widget child;
  final double width;
  final bool expand;

  @override
  _HorizontalExpandState createState() => _HorizontalExpandState();
}

class _HorizontalExpandState extends State<HorizontalExpand>
    with TickerProviderStateMixin {
  late AnimationController controller;
  late Animation<double> animation;
  @override
  void initState() {
    controller = AnimationController(
        duration: const Duration(milliseconds: 250), vsync: this);
    animation = Tween(begin: 0.0, end: 1.0).animate(controller);
    super.initState();
    controller.value = widget.expand ? 1 : 0;
  }

  toggle() {
    if (widget.expand)
      controller.forward();
    else
      controller.reverse();
  }

  @override
  void didUpdateWidget(HorizontalExpand oldWidget) {
    if (oldWidget.expand != widget.expand) {
      print("expand: ${widget.expand}");
      toggle();
    }
    super.didUpdateWidget(oldWidget);
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: animation,
      builder: (context, child) {
        print("animate: ${animation.value}");
        return Visibility(
          visible: animation.value != 0,
          child: Opacity(
            opacity: animation.value,
            child: Transform.scale(
              alignment: Alignment.centerRight,
              scale: animation.value,
              child: widget.child,
            ),
          ),
        );
      },
    );
  }
}
