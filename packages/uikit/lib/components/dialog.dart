import 'dart:ui';

import 'package:flutter/material.dart';

Future showPageAsBottomSheet(
  BuildContext context, {
  required WidgetBuilder builder,
}) {
  return showModalBottomSheet(
    context: context,
    barrierColor: Theme.of(context).dividerColor.withOpacity(0.1),
    isScrollControlled: true,
    backgroundColor: Colors.transparent,
    builder: (_context) => BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 2.0, sigmaY: 2.0),
        child: Wrap(
          children: [
            KeyboardAvoiding(
              child: Card(
                shape: RoundedRectangleBorder(
                    side: BorderSide(color: Theme.of(context).dividerColor)),
                margin: EdgeInsets.fromLTRB(12, 8, 12, 0),
                child: builder(_context),
                elevation: 4,
              ),
            ),
          ],
        )),
  );
}

class KeyboardAvoiding extends StatelessWidget {
  final Widget? child;

  KeyboardAvoiding({
    this.child,
  });

  @override
  Widget build(BuildContext context) {
    final query = MediaQuery.of(context);

    return AnimatedContainer(
      duration: const Duration(milliseconds: 200),
      padding: EdgeInsets.only(bottom: query.viewInsets.bottom),
      child: child,
    );
  }
}
