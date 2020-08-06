import 'package:flutter/material.dart';

import 'goal_tile.dart';

class OptionButton extends StatelessWidget {
  final void Function() onPressed;
  final Widget icon;
  final bool showRightBorder;
  const OptionButton(
      {Key key, this.onPressed, this.icon, this.showRightBorder = true})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressed,
      child: Container(
        width: 45,
        decoration: showRightBorder
            ? BoxDecoration(
                border: Border(
                  right: BorderSide(
                    width: 0.5,
                    color: selectedTileColor,
                  ),
                ),
              )
            : null,
        child: SizedBox.expand(
          child: IconTheme(
            data: IconThemeData(color: Colors.white),
            child: icon,
          ),
        ),
      ),
    );
  }
}
