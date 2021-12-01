import 'package:unofficial_jisho_api/api.dart' as jisho;
export 'package:unofficial_jisho_api/api.dart' show JishoAPIResult; 

Future<jisho.JishoAPIResult> fetchJishoResults(searchTerm) async {
  return jisho.searchForPhrase(searchTerm);
}
