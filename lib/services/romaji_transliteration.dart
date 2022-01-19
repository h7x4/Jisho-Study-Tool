// Source: https://github.com/Kimtaro/ve/blob/master/lib/providers/japanese_transliterators.rb

const hiragana_syllabic_n = 'ん';
const hiragana_small_tsu = 'っ';

const Map<String, String> hiragana_to_latin = {
  'あ': 'a',
  'い': 'i',
  'う': 'u',
  'え': 'e',
  'お': 'o',
  'か': 'ka',
  'き': 'ki',
  'く': 'ku',
  'け': 'ke',
  'こ': 'ko',
  'が': 'ga',
  'ぎ': 'gi',
  'ぐ': 'gu',
  'げ': 'ge',
  'ご': 'go',
  'さ': 'sa',
  'し': 'shi',
  'す': 'su',
  'せ': 'se',
  'そ': 'so',
  'ざ': 'za',
  'じ': 'ji',
  'ず': 'zu',
  'ぜ': 'ze',
  'ぞ': 'zo',
  'た': 'ta',
  'ち': 'chi',
  'つ': 'tsu',
  'て': 'te',
  'と': 'to',
  'だ': 'da',
  'ぢ': 'ji',
  'づ': 'zu',
  'で': 'de',
  'ど': 'do',
  'な': 'na',
  'に': 'ni',
  'ぬ': 'nu',
  'ね': 'ne',
  'の': 'no',
  'は': 'ha',
  'ひ': 'hi',
  'ふ': 'fu',
  'へ': 'he',
  'ほ': 'ho',
  'ば': 'ba',
  'び': 'bi',
  'ぶ': 'bu',
  'べ': 'be',
  'ぼ': 'bo',
  'ぱ': 'pa',
  'ぴ': 'pi',
  'ぷ': 'pu',
  'ぺ': 'pe',
  'ぽ': 'po',
  'ま': 'ma',
  'み': 'mi',
  'む': 'mu',
  'め': 'me',
  'も': 'mo',
  'や': 'ya',
  'ゆ': 'yu',
  'よ': 'yo',
  'ら': 'ra',
  'り': 'ri',
  'る': 'ru',
  'れ': 're',
  'ろ': 'ro',
  'わ': 'wa',
  'うぃ': 'whi',
  'うぇ': 'whe',
  'を': 'wo',
  'ゑ': 'we',
  'ゐ': 'wi',
  'ー': '-',
  'ん': 'n',
  'きゃ': 'kya',
  'きゅ': 'kyu',
  'きょ': 'kyo',
  'きぇ': 'kye',
  'きぃ': 'kyi',
  'ぎゃ': 'gya',
  'ぎゅ': 'gyu',
  'ぎょ': 'gyo',
  'ぎぇ': 'gye',
  'ぎぃ': 'gyi',
  'くぁ': 'kwa',
  'くぃ': 'kwi',
  'くぅ': 'kwu',
  'くぇ': 'kwe',
  'くぉ': 'kwo',
  'ぐぁ': 'qwa',
  'ぐぃ': 'gwi',
  'ぐぅ': 'gwu',
  'ぐぇ': 'gwe',
  'ぐぉ': 'gwo',
  'しゃ': 'sha',
  'しぃ': 'syi',
  'しゅ': 'shu',
  'しぇ': 'she',
  'しょ': 'sho',
  'じゃ': 'ja',
  'じゅ': 'ju',
  'じぇ': 'jye',
  'じょ': 'jo',
  'じぃ': 'jyi',
  'すぁ': 'swa',
  'すぃ': 'swi',
  'すぅ': 'swu',
  'すぇ': 'swe',
  'すぉ': 'swo',
  'ちゃ': 'cha',
  'ちゅ': 'chu',
  'ちぇ': 'tye',
  'ちょ': 'cho',
  'ちぃ': 'tyi',
  'ぢゃ': 'ja',
  'ぢぃ': 'dyi',
  'ぢゅ': 'ju',
  'ぢぇ': 'dye',
  'ぢょ': 'jo',
  'つぁ': 'tsa',
  'つぃ': 'tsi',
  'つぇ': 'tse',
  'つぉ': 'tso',
  'てゃ': 'tha',
  'てぃ': 'thi',
  'てゅ': 'thu',
  'てぇ': 'the',
  'てょ': 'tho',
  'とぁ': 'twa',
  'とぃ': 'twi',
  'とぅ': 'twu',
  'とぇ': 'twe',
  'とぉ': 'two',
  'でゃ': 'dha',
  'でぃ': 'dhi',
  'でゅ': 'dhu',
  'でぇ': 'dhe',
  'でょ': 'dho',
  'どぁ': 'dwa',
  'どぃ': 'dwi',
  'どぅ': 'dwu',
  'どぇ': 'dwe',
  'どぉ': 'dwo',
  'にゃ': 'nya',
  'にゅ': 'nyu',
  'にょ': 'nyo',
  'にぇ': 'nye',
  'にぃ': 'nyi',
  'ひゃ': 'hya',
  'ひぃ': 'hyi',
  'ひゅ': 'hyu',
  'ひぇ': 'hye',
  'ひょ': 'hyo',
  'びゃ': 'bya',
  'びぃ': 'byi',
  'びゅ': 'byu',
  'びぇ': 'bye',
  'びょ': 'byo',
  'ぴゃ': 'pya',
  'ぴぃ': 'pyi',
  'ぴゅ': 'pyu',
  'ぴぇ': 'pye',
  'ぴょ': 'pyo',
  'ふぁ': 'fwa',
  'ふぃ': 'fyi',
  'ふぇ': 'fye',
  'ふぉ': 'fwo',
  'ふぅ': 'fwu',
  'ふゃ': 'fya',
  'ふゅ': 'fyu',
  'ふょ': 'fyo',
  'みゃ': 'mya',
  'みぃ': 'myi',
  'みゅ': 'myu',
  'みぇ': 'mye',
  'みょ': 'myo',
  'りゃ': 'rya',
  'りぃ': 'ryi',
  'りゅ': 'ryu',
  'りぇ': 'rye',
  'りょ': 'ryo',
  'ゔぁ': 'va',
  'ゔぃ': 'vyi',
  'ゔ': 'vu',
  'ゔぇ': 'vye',
  'ゔぉ': 'vo',
  'ゔゃ': 'vya',
  'ゔゅ': 'vyu',
  'ゔょ': 'vyo',
  'うぁ': 'wha',
  'いぇ': 'ye',
  'うぉ': 'who',
  'ぁ': 'xa',
  'ぃ': 'xi',
  'ぅ': 'xu',
  'ぇ': 'xe',
  'ぉ': 'xo',
  'ゕ': 'xka',
  'ゖ': 'xke',
  'ゎ': 'xwa'
};

const Map<String, String> latin_to_hiragana = {
  'a': 'あ',
  'i': 'い',
  'u': 'う',
  'e': 'え',
  'o': 'お',
  'ka': 'か',
  'ki': 'き',
  'ku': 'く',
  'ke': 'け',
  'ko': 'こ',
  'ga': 'が',
  'gi': 'ぎ',
  'gu': 'ぐ',
  'ge': 'げ',
  'go': 'ご',
  'sa': 'さ',
  'si': 'し',
  'shi': 'し',
  'su': 'す',
  'se': 'せ',
  'so': 'そ',
  'za': 'ざ',
  'zi': 'じ',
  'ji': 'じ',
  'zu': 'ず',
  'ze': 'ぜ',
  'zo': 'ぞ',
  'ta': 'た',
  'ti': 'ち',
  'chi': 'ち',
  'tu': 'つ',
  'tsu': 'つ',
  'te': 'て',
  'to': 'と',
  'da': 'だ',
  'di': 'ぢ',
  'du': 'づ',
  'dzu': 'づ',
  'de': 'で',
  'do': 'ど',
  'na': 'な',
  'ni': 'に',
  'nu': 'ぬ',
  'ne': 'ね',
  'no': 'の',
  'ha': 'は',
  'hi': 'ひ',
  'hu': 'ふ',
  'fu': 'ふ',
  'he': 'へ',
  'ho': 'ほ',
  'ba': 'ば',
  'bi': 'び',
  'bu': 'ぶ',
  'be': 'べ',
  'bo': 'ぼ',
  'pa': 'ぱ',
  'pi': 'ぴ',
  'pu': 'ぷ',
  'pe': 'ぺ',
  'po': 'ぽ',
  'ma': 'ま',
  'mi': 'み',
  'mu': 'む',
  'me': 'め',
  'mo': 'も',
  'ya': 'や',
  'yu': 'ゆ',
  'yo': 'よ',
  'ra': 'ら',
  'ri': 'り',
  'ru': 'る',
  're': 'れ',
  'ro': 'ろ',
  'la': 'ら',
  'li': 'り',
  'lu': 'る',
  'le': 'れ',
  'lo': 'ろ',
  'wa': 'わ',
  'wi': 'うぃ',
  'we': 'うぇ',
  'wo': 'を',
  'wye': 'ゑ',
  'wyi': 'ゐ',
  '-': 'ー',
  'n': 'ん',
  'nn': 'ん',
  "n'": 'ん',
  'kya': 'きゃ',
  'kyu': 'きゅ',
  'kyo': 'きょ',
  'kye': 'きぇ',
  'kyi': 'きぃ',
  'gya': 'ぎゃ',
  'gyu': 'ぎゅ',
  'gyo': 'ぎょ',
  'gye': 'ぎぇ',
  'gyi': 'ぎぃ',
  'kwa': 'くぁ',
  'kwi': 'くぃ',
  'kwu': 'くぅ',
  'kwe': 'くぇ',
  'kwo': 'くぉ',
  'gwa': 'ぐぁ',
  'gwi': 'ぐぃ',
  'gwu': 'ぐぅ',
  'gwe': 'ぐぇ',
  'gwo': 'ぐぉ',
  'qwa': 'ぐぁ',
  'qwi': 'ぐぃ',
  'qwu': 'ぐぅ',
  'qwe': 'ぐぇ',
  'qwo': 'ぐぉ',
  'sya': 'しゃ',
  'syi': 'しぃ',
  'syu': 'しゅ',
  'sye': 'しぇ',
  'syo': 'しょ',
  'sha': 'しゃ',
  'shu': 'しゅ',
  'she': 'しぇ',
  'sho': 'しょ',
  'ja': 'じゃ',
  'ju': 'じゅ',
  'je': 'じぇ',
  'jo': 'じょ',
  'jya': 'じゃ',
  'jyi': 'じぃ',
  'jyu': 'じゅ',
  'jye': 'じぇ',
  'jyo': 'じょ',
  'zya': 'じゃ',
  'zyu': 'じゅ',
  'zyo': 'じょ',
  'zye': 'じぇ',
  'zyi': 'じぃ',
  'swa': 'すぁ',
  'swi': 'すぃ',
  'swu': 'すぅ',
  'swe': 'すぇ',
  'swo': 'すぉ',
  'cha': 'ちゃ',
  'chu': 'ちゅ',
  'che': 'ちぇ',
  'cho': 'ちょ',
  'cya': 'ちゃ',
  'cyi': 'ちぃ',
  'cyu': 'ちゅ',
  'cye': 'ちぇ',
  'cyo': 'ちょ',
  'tya': 'ちゃ',
  'tyi': 'ちぃ',
  'tyu': 'ちゅ',
  'tye': 'ちぇ',
  'tyo': 'ちょ',
  'dya': 'ぢゃ',
  'dyi': 'ぢぃ',
  'dyu': 'ぢゅ',
  'dye': 'ぢぇ',
  'dyo': 'ぢょ',
  'tsa': 'つぁ',
  'tsi': 'つぃ',
  'tse': 'つぇ',
  'tso': 'つぉ',
  'tha': 'てゃ',
  'thi': 'てぃ',
  'thu': 'てゅ',
  'the': 'てぇ',
  'tho': 'てょ',
  'twa': 'とぁ',
  'twi': 'とぃ',
  'twu': 'とぅ',
  'twe': 'とぇ',
  'two': 'とぉ',
  'dha': 'でゃ',
  'dhi': 'でぃ',
  'dhu': 'でゅ',
  'dhe': 'でぇ',
  'dho': 'でょ',
  'dwa': 'どぁ',
  'dwi': 'どぃ',
  'dwu': 'どぅ',
  'dwe': 'どぇ',
  'dwo': 'どぉ',
  'nya': 'にゃ',
  'nyu': 'にゅ',
  'nyo': 'にょ',
  'nye': 'にぇ',
  'nyi': 'にぃ',
  'hya': 'ひゃ',
  'hyi': 'ひぃ',
  'hyu': 'ひゅ',
  'hye': 'ひぇ',
  'hyo': 'ひょ',
  'bya': 'びゃ',
  'byi': 'びぃ',
  'byu': 'びゅ',
  'bye': 'びぇ',
  'byo': 'びょ',
  'pya': 'ぴゃ',
  'pyi': 'ぴぃ',
  'pyu': 'ぴゅ',
  'pye': 'ぴぇ',
  'pyo': 'ぴょ',
  'fa': 'ふぁ',
  'fi': 'ふぃ',
  'fe': 'ふぇ',
  'fo': 'ふぉ',
  'fwa': 'ふぁ',
  'fwi': 'ふぃ',
  'fwu': 'ふぅ',
  'fwe': 'ふぇ',
  'fwo': 'ふぉ',
  'fya': 'ふゃ',
  'fyi': 'ふぃ',
  'fyu': 'ふゅ',
  'fye': 'ふぇ',
  'fyo': 'ふょ',
  'mya': 'みゃ',
  'myi': 'みぃ',
  'myu': 'みゅ',
  'mye': 'みぇ',
  'myo': 'みょ',
  'rya': 'りゃ',
  'ryi': 'りぃ',
  'ryu': 'りゅ',
  'rye': 'りぇ',
  'ryo': 'りょ',
  'lya': 'りゃ',
  'lyu': 'りゅ',
  'lyo': 'りょ',
  'lye': 'りぇ',
  'lyi': 'りぃ',
  'va': 'ゔぁ',
  'vi': 'ゔぃ',
  'vu': 'ゔ',
  've': 'ゔぇ',
  'vo': 'ゔぉ',
  'vya': 'ゔゃ',
  'vyi': 'ゔぃ',
  'vyu': 'ゔゅ',
  'vye': 'ゔぇ',
  'vyo': 'ゔょ',
  'wha': 'うぁ',
  'whi': 'うぃ',
  'ye': 'いぇ',
  'whe': 'うぇ',
  'who': 'うぉ',
  'xa': 'ぁ',
  'xi': 'ぃ',
  'xu': 'ぅ',
  'xe': 'ぇ',
  'xo': 'ぉ',
  'xya': 'ゃ',
  'xyu': 'ゅ',
  'xyo': 'ょ',
  'xtu': 'っ',
  'xtsu': 'っ',
  'xka': 'ゕ',
  'xke': 'ゖ',
  'xwa': 'ゎ',
  '@@': '　',
  '#[': '「',
  '#]': '」',
  '#,': '、',
  '#.': '。',
  '#/': '・',
};

bool _smallTsu(String for_conversion) => for_conversion == hiragana_small_tsu;
bool _nFollowedByYuYeYo(String for_conversion, String kana) =>
    for_conversion == hiragana_syllabic_n &&
    kana.length > 1 &&
    'やゆよ'.contains(kana.substring(1, 2));

String transliterateHiraganaToLatin(String hiragana) {
  String kana = hiragana;
  String romaji = '';
  bool geminate = false;

  while (kana.isNotEmpty) {
    final lengths = [if (kana.length > 1) 2, 1];
    for (final length in lengths) {
      final String for_conversion = kana.substring(0, length);
      String? mora;

      if (_smallTsu(for_conversion)) {
        geminate = true;
        kana = kana.replaceRange(0, length, '');
        break;
      } else if (_nFollowedByYuYeYo(for_conversion, kana)) {
        mora = "n'";
      }
      mora ??= hiragana_to_latin[for_conversion];

      if (mora != null) {
        if (geminate) {
          geminate = false;
          romaji += mora.substring(0, 1);
        }
        romaji += mora;
        kana = kana.replaceRange(0, length, '');
        break;
      } else if (length == 1) {
        romaji += for_conversion;
        kana = kana.replaceRange(0, length, '');
      }
    }
  }
  return romaji;
}

bool _doubleNFollowedByAIUEO(String for_conversion) =>
    RegExp(r'^nn[aiueo]$').hasMatch(for_conversion);
bool _hasTableMatch(String for_conversion) =>
    latin_to_hiragana[for_conversion] != null;
bool _hasDoubleConsonant(String for_conversion, int length) =>
    for_conversion == 'tch' ||
    (length == 2 &&
        RegExp(r'^([kgsztdnbpmyrlwchf])\1$').hasMatch(for_conversion));

String transliterateLatinToHiragana(String latin) {
  String romaji =
      latin.toLowerCase().replaceAll('mb', 'nb').replaceAll('mp', 'np');
  String kana = '';

  while (romaji.isNotEmpty) {
    final lengths = [
      if (romaji.length > 2) 3,
      if (romaji.length > 1) 2,
      1,
    ];

    for (final length in lengths) {
      String? mora;
      int for_removal = length;
      final String for_conversion = romaji.substring(0, length);

      if (_doubleNFollowedByAIUEO(for_conversion)) {
        mora = hiragana_syllabic_n;
        for_removal = 1;
      } else if (_hasTableMatch(for_conversion)) {
        mora = latin_to_hiragana[for_conversion];
      } else if (_hasDoubleConsonant(for_conversion, length)) {
        mora = hiragana_small_tsu;
        for_removal = 1;
      }

      if (mora != null) {
        kana += mora;
        romaji = romaji.replaceRange(0, for_removal, '');
        break;
      } else if (length == 1) {
        kana += for_conversion;
        romaji = romaji.replaceRange(0, 1, '');
      }
    }
  }

  return kana;
}

String _transposeCodepointsInRange(
  String text,
  int distance,
  int rangeStart,
  int rangeEnd,
) =>
    String.fromCharCodes(
      text.codeUnits
          .map((c) => c + ((rangeStart <= c && c <= rangeEnd) ? distance : 0)),
    );

String transliterateKanaToLatin(String kana) =>
    transliterateHiraganaToLatin(transliterateKatakanaToHiragana(kana));

String transliterateLatinToKatakana(String latin) =>
    transliterateHiraganaToKatakana(transliterateLatinToHiragana(latin));

String transliterateKatakanaToHiragana(String katakana) =>
    _transposeCodepointsInRange(katakana, -96, 12449, 12534);

String transliterateHiraganaToKatakana(String hiragana) =>
    _transposeCodepointsInRange(hiragana, 96, 12353, 12438);

String transliterateFullwidthRomajiToHalfwidth(String halfwidth) =>
    _transposeCodepointsInRange(
      _transposeCodepointsInRange(
        halfwidth,
        -65248,
        65281,
        65374,
      ),
      -12256,
      12288,
      12288,
    );

String transliterateHalfwidthRomajiToFullwidth(String halfwidth) =>
    _transposeCodepointsInRange(
      _transposeCodepointsInRange(
        halfwidth,
        65248,
        33,
        126,
      ),
      12256,
      32,
      32,
    );
