import 'package:flutter/material.dart';

import 'goal_tile.dart' show formColor;

class FormItem extends StatelessWidget {
  final Widget label;
  final Widget icon;
  final void Function() onPressed;

  const FormItem(this.label, this.icon, {Key key, this.onPressed})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    Widget child = Container(
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: formColor,
        borderRadius: BorderRadius.circular(2),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [label, icon],
      ),
    );
    if (onPressed != null) {
      child = GestureDetector(
        child: child,
        onTap: onPressed,
      );
    }
    return child;
  }
}
