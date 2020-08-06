import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:goal_details/commons/assets.dart';
import 'package:goal_details/commons/setup.dart';
import 'package:goal_details/models/notifier/goal.dart';
import 'package:goal_details/models/objects/goal.dart';
import 'package:goal_details/ui/components.dart/goal_tile.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';
import 'package:expandable/expandable.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  Box<Goal> goalDetailsBox;
  @override
  void initState() {
    goalDetailsBox = Hive.box<Goal>(goalDetailsBoxName);
    super.initState();
  }

  @override
  void didChangeDependencies() {
    setupImages(context); // pre-caches images
    super.didChangeDependencies();
  }

  void addGoal() async {
    int goalNumber = goalDetailsBox.length + 1;
    DateTime creationTime = DateTime.now();
    final Goal goal =
        Goal(title: 'My Goals $goalNumber', creationTime: creationTime);
    goalDetailsBox.add(goal);
  }

  void showMore() {
    // TODO Implement
    throw UnimplementedError();
  }

  void editSelected() {
    // TODO Implement
    throw UnimplementedError();
  }

  void removeGoal(dynamic key) {
    goalDetailsBox.delete(key);
  }

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: const BoxDecoration(
        image: const DecorationImage(
          image: AppAssets.background,
          fit: BoxFit.fill,
        ),
      ),
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Goals'),
          actions: [
            IconButton(
              icon: Icon(LineAwesomeIcons.plus_circle, color: Colors.white),
              onPressed: addGoal,
            ),
            IconButton(
              icon: Icon(LineAwesomeIcons.edit, color: Colors.white),
              onPressed: editSelected,
            ),
            IconButton(
              icon: Icon(Icons.more_vert, color: Colors.white),
              onPressed: showMore,
            ),
          ],
        ),
        backgroundColor: Colors.transparent,
        body: ValueListenableBuilder(
          valueListenable: goalDetailsBox.listenable(),
          builder: (context, Box<Goal> goals, _) {
            final List<int> keys = goals.keys.cast<int>().toList();
            if (keys?.isEmpty ?? true) {
              return Center(
                child: OutlineButton(
                  child: Text('Create a goal'),
                  textColor: Colors.white,
                  onPressed: addGoal,
                ),
              );
            }
            return ListView.builder(
              itemBuilder: (_, int index) {
                final int boxKey = keys[index];
                final Goal goal = goals.get(boxKey);
                return ChangeNotifierProvider<GoalProvider>(
                  create: (_) => GoalProvider(goals, goal),
                  child: GoalTile(),
                );
              },
              itemCount: keys.length,
              shrinkWrap: true,
            );
          },
        ),
      ),
    );
  }
}
