import 'package:expandable/expandable.dart';
import 'package:flutter/material.dart';
import 'package:goal_details/models/notifier/goal.dart';
import 'package:goal_details/models/objects/goal.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';
import 'package:hive/hive.dart';
import 'package:provider/provider.dart';

import 'goal_form.dart';
import 'option_button.dart';
import 'progress_percentage.dart';

const Color unselectedTileColor = Color(0xff8780a7);
const Color moreOptionColor = Color(0xff658bcd);
const Color selectedTileColor = Color(0xff466cae);
const Color formColor = Color(0xff538eb3);

class GoalTile extends StatefulWidget {
  const GoalTile({
    Key key,
  }) : super(key: key);

  @override
  _GoalTileState createState() => _GoalTileState();
}

class _GoalTileState extends State<GoalTile> {
  bool optionsVisible = false;
  ExpandableController controller;
  GoalProvider provider;

  @override
  void initState() {
    super.initState();
    controller = ExpandableController();
  }

  @override
  void didChangeDependencies() {
    provider = Provider.of<GoalProvider>(context);
    super.didChangeDependencies();
  }

  void changeOptionVisibility(bool visible) {
    setState(() {
      optionsVisible = visible;
    });
  }

  @override
  Widget build(BuildContext context) {
    final Widget options = Visibility(
      visible: optionsVisible,
      child: Container(
        color: moreOptionColor,
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            // delete
            OptionButton(
              onPressed: () {
                provider.delete();
              },
              icon: Icon(
                Icons.delete_outline,
              ),
            ),
            // Expands the goal tile expandable
            OptionButton(
              onPressed: controller.toggle,
              icon: Icon(LineAwesomeIcons.edit, color: Colors.white),
            ),
            // share
            OptionButton(
              onPressed: null,
              icon: Icon(Icons.share),
            ),
            // target
            OptionButton(
              onPressed: null,
              showRightBorder: false,
              icon: Icon(Icons.track_changes),
            ),
          ],
        ),
      ),
      replacement: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          CircularPercentageIndicator(
            value: provider.completed,
            backgroundColor: unselectedTileColor,
            strokeWidth: 2,
          ),
          IconButton(
            icon: Icon(Icons.more_vert, color: Colors.white),
            onPressed: () => changeOptionVisibility(true),
          ),
        ],
      ),
    );
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 20,
        vertical: 2,
      ),
      child: ExpandableNotifier(
        controller: controller,
        child: Expandable(
          collapsed: Container(
            decoration: BoxDecoration(
              color: optionsVisible ? selectedTileColor : unselectedTileColor,
              borderRadius: BorderRadius.circular(4.0),
              border: Border.all(color: Colors.white, width: 0.2),
            ),
            child: ListTile(
              contentPadding: EdgeInsets.zero,
              title: Padding(
                padding: const EdgeInsets.only(left: 18.0),
                child: Text(
                  provider.title,
                  style: TextStyle(
                    color: Colors.white,
                  ),
                ),
              ),
              onTap: () => changeOptionVisibility(false),
              trailing: options,
            ),
          ),
          expanded: GoalForm(),
        ),
      ),
    );
  }
}
