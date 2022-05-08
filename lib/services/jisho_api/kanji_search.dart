import 'package:unofficial_jisho_api/api.dart' as jisho;
export 'package:unofficial_jisho_api/api.dart' show KanjiResult;

Future<jisho.KanjiResult> fetchKanji(String kanji) =>
    jisho.searchForKanji(kanji);
