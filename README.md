# goal_details

A flutter application to collect goal details from the user

<!-- developed for Mobile App Development internship of CyntraLabs Private Limited. -->

## Description

### Preview of goal's page

The application's home page just has a button to the page with a list of user's goals.

The percentage indicator in the middle shows the ratio of time elapsed and the total duration of the goal since it's creation.

<img src="https://github.com/predatorx7/goal_details/blob/master/result_preview/flutter_01.png" width="400">

### Preview of modification form

When a goal is created, all fields including the end date is empty. By default, creation time + 1 day is assumed to be the end date, goal type is personal if provided null.

<img src="https://github.com/predatorx7/goal_details/blob/master/result_preview/flutter_02.png" width="400">

### Issues

- The purpose for Global edit and more actions on the goal page's app bar was not clear and is unimplemented.
- The share button and target button does not work.
- Percentage Indicator might not update **live**.

Note: The package analyzer's version has been overridden to 0.39.14 as a workaround to fix an issue that causes build_runner to run indefinitely in flutter:v1.20.0
