import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:goal_details/ui/screens/goals.dart';
import 'package:goal_details/ui/screens/home.dart';

import 'route_const.dart';

/// Wraps [screen] with a [PageRoute]
PageRoute wrapPageRoute(Widget screen, [bool useCupertinoPageRoute = true]) {
  if (useCupertinoPageRoute) {
    return CupertinoPageRoute(builder: (context) => screen);
  }
  return MaterialPageRoute(
    builder: (context) => screen,
  );
}

/// Generates Routes which will be used in the application
Route<dynamic> generateRoute(RouteSettings settings) {
  switch (settings.name) {
    case RouteNames.GoalsRoute:
      return wrapPageRoute(GoalsScreen());
    case RouteNames.RootRoute:
    default:
      return wrapPageRoute(HomeScreen());
  }
}
