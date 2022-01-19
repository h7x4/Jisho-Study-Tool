import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';

final SharedPreferences _prefs = GetIt.instance.get<SharedPreferences>();

const Map<String, dynamic> _defaults = {
  'romajiEnabled': false,
  'darkThemeEnabled': false,
  'autoThemeEnabled': false,
};

bool _getSettingOrDefault(String settingName) =>
    _prefs.getBool(settingName) ?? _defaults[settingName];

bool get romajiEnabled => _getSettingOrDefault('romajiEnabled');
bool get darkThemeEnabled => _getSettingOrDefault('darkThemeEnabled');
bool get autoThemeEnabled => _getSettingOrDefault('autoThemeEnabled');

set romajiEnabled(b) => _prefs.setBool('romajiEnabled', b);
set darkThemeEnabled(b) => _prefs.setBool('darkThemeEnabled', b);
set autoThemeEnabled(b) => _prefs.setBool('autoThemeEnabled', b);
