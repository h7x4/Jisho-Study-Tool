import 'package:unofficial_jisho_api/parser.dart';

// TODO: This should be moved to the api.
extension KanjiFurigana on JishoJapaneseWord {

  // Both wordReading and word.word being present implies that the word has furigana.
  // If that's not the case, then the word is usually present in wordReading.
  // However, there are some exceptions where the reading is placed in word.
  bool get hasFurigana => word != null && reading != null;
  String get kanji => word ?? reading!;
  String? get furigana => hasFurigana ? reading! : null;
}
