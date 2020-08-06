import 'package:flutter/material.dart';
import 'package:expandable/expandable.dart';
import 'package:goal_details/models/notifier/goal.dart';
import 'package:goal_details/models/objects/goal.dart';
import 'package:provider/provider.dart';

import 'form_item.dart';

const EdgeInsets _expansionPanelPadding = const EdgeInsets.fromLTRB(4, 4, 4, 0);
const TextStyle _whiteTextStyle = TextStyle(color: Colors.white);
const LinearGradient _expansionHeaderGradient = const LinearGradient(
  begin: const Alignment(-1, -1),
  end: const Alignment(1, 1),
  stops: const [0, 0.1, 0.6],
  colors: const [
    const Color(0xffe66fb3),
    const Color(0xffcf76af),
    const Color(0xffb282aa),
  ],
);

class GoalForm extends StatefulWidget {
  const GoalForm({
    Key key,
  }) : super(key: key);

  @override
  _GoalFormState createState() => _GoalFormState();
}

class _GoalFormState extends State<GoalForm> {
  ExpandableController controller;
  GoalProvider provider;

  // The below fields will store user selected choices
  DateTime tempDate;
  DateTime tempSGIDate;
  TimeOfDay tempTimeOfDay;
  GoalType tempGoalType;

  @override
  void didChangeDependencies() {
    controller = ExpandableController.of(context);
    provider = Provider.of<GoalProvider>(context);
    _provideIfNull();
    super.didChangeDependencies();
  }

  void _provideIfNull() {
    tempDate ??= provider.targetDate;
    tempSGIDate ??= provider.targetSGIDate;
    tempTimeOfDay ??= provider.targetTimeOfDay;
    tempGoalType ??= provider.goalType;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(4.0),
        color: Colors.white.withOpacity(0.2),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          ExpandableButton(
            child: Container(
              width: double.infinity,
              height: 100,
              decoration: const BoxDecoration(
                gradient: _expansionHeaderGradient,
                color: const Color(0xffcf76af),
              ),
              child: Center(
                child: Text(
                  'Enter/Update details',
                  style: _whiteTextStyle,
                ),
              ),
            ),
          ),
          Padding(
            padding: _expansionPanelPadding,
            child: ExpandablePanel(
              hasIcon: false,
              tapBodyToCollapse: false,
              header: FormItem(
                Text(
                  'Target Date',
                  style: _whiteTextStyle,
                ),
                Icon(
                  controller.expanded
                      ? Icons.arrow_drop_up
                      : Icons.arrow_drop_down,
                  color: Colors.white,
                ),
              ),
              expanded: Row(
                children: [
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.only(top: 4, right: 2),
                      child: FormItem(
                        Text('Date', style: _whiteTextStyle),
                        Icon(Icons.calendar_today, color: Colors.white),
                        onPressed: () async {
                          tempDate = await showDatePicker(
                            context: context,
                            initialDate: tempDate,
                            firstDate: DateTime(2000),
                            lastDate: DateTime(2050),
                          );
                          _provideIfNull();
                        },
                      ),
                    ),
                  ),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.only(top: 4, left: 2),
                      child: FormItem(
                        Text('SGI Date', style: _whiteTextStyle),
                        Icon(Icons.calendar_today, color: Colors.white),
                        onPressed: () async {
                          tempSGIDate = await showDatePicker(
                            context: context,
                            initialDate: tempSGIDate,
                            firstDate: DateTime(2000),
                            lastDate: DateTime(2050),
                          );
                          _provideIfNull();
                        },
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 4.0, vertical: 4.0),
            width: double.infinity,
            child: FormItem(
              Text(
                'Time',
                style: _whiteTextStyle,
              ),
              Icon(
                Icons.schedule,
                color: Colors.white,
              ),
              onPressed: () async {
                tempTimeOfDay = await showTimePicker(
                  context: context,
                  initialTime: tempTimeOfDay,
                );
                _provideIfNull();
              },
            ),
          ),
          FlatButton(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(18.0),
            ),
            color: Colors.white,
            textColor: Colors.black,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 80),
              child: Text("Add"),
            ),
            onPressed: () async {
              provider.save(
                selectDate: tempDate,
                selectTimeOfDay: tempTimeOfDay,
                selectSGIDate: tempSGIDate,
                selectGoalType: tempGoalType,
              );
              controller.toggle();
            },
          ),
        ],
      ),
    );
  }
}
