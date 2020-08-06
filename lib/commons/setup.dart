import 'package:flutter/widgets.dart';
import 'package:goal_details/commons/assets.dart';
import 'package:goal_details/models/objects/goal.dart';
import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart';

const String goalDetailsBoxName = 'goalDetailsBox';

Future<void> setupHive() async {
  final document = await getApplicationDocumentsDirectory();
  Hive.init(document.path);
  Hive.registerAdapter(GoalAdapter());
  Hive.registerAdapter(GoalTypeAdapter());
  await Hive.openBox<Goal>(goalDetailsBoxName);
}

void setupImages(BuildContext context) async {
  await precacheImage(AppAssets.background, context);
}

Future<void> setup() async {
  WidgetsFlutterBinding.ensureInitialized();
  await setupHive();
}
