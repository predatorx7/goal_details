import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:goal_details/models/notifier/goal.dart';
import 'package:goal_details/ui/components.dart/progress_percentage.dart';
import 'package:goal_details/ui/components.dart/scaffold_cover.dart';
import 'package:provider/provider.dart';

class GoalDescription extends StatelessWidget {
  Widget build(BuildContext context) {
    final GoalProvider provider = Provider.of<GoalProvider>(context);
    final DateFormat dateFormatter = DateFormat('dd MMM, yyyy');
    final DateFormat timeFormatter = DateFormat.jm();
    final DateFormat formatter = DateFormat('dd MMM, yyyy h:mm a');

    // Formats DateTime in dd-MM-yy
    final String formattedExpirationDate = provider.goal?.targetDate != null
        ? dateFormatter.format(provider.goal.targetDate)
        : '';
    // Formats DateTime in hours and minutes (12 hours)
    final String formattedExpirationTime = provider.goal?.targetTime != null
        ? timeFormatter.format(provider.goal.targetTime)
        : '';

    final String formattedCreationDateTime =
        formatter.format(provider.goal.creationTime);

    final String describedGoalType = describeEnum(provider.goalType.toString());

    return ScaffoldCover(
      scaffold: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          title: Text(provider.title),
          automaticallyImplyLeading: false,
          leading: IconButton(
            icon: Icon(CupertinoIcons.back),
            onPressed: () => Navigator.maybePop(context),
          ),
        ),
        body: ListView(
          children: [
            ListTile(
              title: Text('Percentage completed'),
              trailing: CircularPercentageIndicator(
                value: provider.completed,
              ),
            ),
            ListTile(
              title: Text('Creation'),
              trailing: Text(formattedCreationDateTime),
            ),
            ListTile(
              title: Text('Expiration'),
              trailing:
                  Text('$formattedExpirationDate $formattedExpirationTime'),
            ),
            ListTile(
              title: Text('Goal type'),
              trailing: Text(describedGoalType),
            ),
          ],
        ),
      ),
    );
  }
}
