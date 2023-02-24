import 'package:unofficial_jisho_api/api.dart';
export 'package:unofficial_jisho_api/api.dart' show JishoAPIResult;

Future<JishoAPIResult> fetchJishoResults(searchTerm) =>
    searchForPhrase(searchTerm);
