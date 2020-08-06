import 'package:flutter/material.dart';
import 'package:goal_details/commons/assets.dart';

class ScaffoldCover extends StatelessWidget {
  final Scaffold scaffold;

  const ScaffoldCover({Key key, this.scaffold}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: const BoxDecoration(
        image: const DecorationImage(
          image: AppAssets.background,
          fit: BoxFit.fill,
        ),
      ),
      child: scaffold,
    );
  }
}
