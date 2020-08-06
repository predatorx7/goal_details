import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'commons/routes.dart';
import 'commons/setup.dart';

void main() async {
  await setup();
  runApp(GoalDetailsApp());
}

class GoalDetailsApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final TextTheme openSans = GoogleFonts.openSansTextTheme();
    return MaterialApp(
      title: 'Goal details',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        textTheme: openSans,
        appBarTheme: AppBarTheme(
          color: Colors.transparent,
          shadowColor: Colors.transparent,
          elevation: 0,
          textTheme: openSans.apply(
            bodyColor: Colors.white, // Changes title text color
          ),
          centerTitle: true,
        ),
      ),
      onGenerateRoute: generateRoute,
    );
  }
}
