import 'package:unofficial_jisho_api/api.dart' as jisho;

Future<jisho.JishoAPIResult> fetchJishoResults(searchTerm) async {
  return await jisho.searchForPhrase(searchTerm);
}