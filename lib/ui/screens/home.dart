import 'package:flutter/material.dart';
import 'package:goal_details/commons/route_const.dart';
import 'package:goal_details/ui/components.dart/scaffold_cover.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ScaffoldCover(
      scaffold: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          title: Title(
            title: 'Goals',
            color: Colors.white,
            child: Text(
              'Goals',
              style: TextStyle(fontSize: 30),
            ),
          ),
        ),
        body: Center(
          child: FlatButton.icon(
            icon: Icon(Icons.navigate_next),
            label: Text('Show my goals'),
            onPressed: () {
              Navigator.of(context).pushNamed(RouteNames.GoalsRoute);
            },
          ),
        ),
      ),
    );
  }
}
