import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';

Future<void> setupSharedPreferences() async {
  final SharedPreferences prefs = await SharedPreferences.getInstance();
  GetIt.instance.registerSingleton<SharedPreferences>(prefs);
}
