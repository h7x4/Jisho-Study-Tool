import 'dart:io';

import 'package:get_it/get_it.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sembast/sembast.dart';
import 'package:sembast/sembast_io.dart';

Future<void> setupDatabase() async {
  final Directory appDocDir = await getApplicationDocumentsDirectory();
  if (!appDocDir.existsSync()) appDocDir.createSync(recursive: true);
  final Database database =
      await databaseFactoryIo.openDatabase(join(appDocDir.path, 'sembast.db'));
  GetIt.instance.registerSingleton<Database>(database);
}
