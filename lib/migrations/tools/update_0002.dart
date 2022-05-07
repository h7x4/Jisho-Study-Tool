import 'package:html/parser.dart';
import 'package:http/http.dart' as http;
import 'package:unofficial_jisho_api/api.dart';

// TODO: Clean up code and automate process.

class Radical {
  final int id;
  final String symbol;
  final String? search_symbol;
  final String meaning;
  final int strokes;

  const Radical({
    required this.id,
    required this.symbol,
    required this.strokes,
    required this.meaning,
    this.search_symbol,
  });

  @override
  String toString() {
    return '$id - ($symbol, $strokes${search_symbol != null ? ", $search_symbol" : ""})';
  }

  String get sql_insert => search_symbol == null
      ? 'INSERT INTO Kanji_Radical (id, symbol, strokes, meaning) '
          "VALUES ($id, '$symbol', $strokes, '$meaning');"
      : 'INSERT INTO Kanji_Radical (id, symbol, strokes, meaning, searchSymbol) '
          "VALUES ($id, '$symbol', $strokes, '$meaning', '$search_symbol');";
}

String hexToUnicode(String code) =>
    String.fromCharCode(int.parse(code, radix: 16));

/// Some of the radicals in jisho are written using katakana,
/// and some are written using either the symbols from the
/// Kangxi radical block (U+2F00-U+2FDF) or the
/// Unified CJK Character block (U+4E00-U+9FFF). These have been
/// used without care, and therefore some of the radicals are not
/// easily searchable. This conversion table helps solve this issue.
///
/// See:
/// https://en.wikipedia.org/wiki/List_of_radicals_in_Unicode
/// https://second.wiki/wiki/unicodeblock_kangxi-radikale
/// https://wiki.contextgarden.net/List_of_Unicode_blocks
Future<Map<String, String>> fetchEquivalentUCJKIdeographs() async {
  final response = await http.get(
    Uri.parse(
      'https://www.unicode.org/Public/UNIDATA/EquivalentUnifiedIdeograph.txt',
    ),
  );
  final Map<String, String> result = {};

  for (final line in response.body.split('\n')) {
    if (line.startsWith('#') || RegExp(r'^\s*$').hasMatch(line)) continue;
    final items = line.split(RegExp(r'\s+'));

    if (items[0].contains('.')) {
      final startEnd = items[0].split('..');
      final start = int.parse(startEnd[0], radix: 16);
      final end = int.parse(startEnd[1], radix: 16);
      for (int i = 0; i <= (end - start); i++) {
        result[String.fromCharCode(start + i)] = hexToUnicode(items[2]);
      }
    } else {
      result[hexToUnicode(items[0])] = hexToUnicode(items[2]);
    }
  }

  return result;
}

Future<void> main(List<String> args) async {
  final Map<String, String> equivalentSymbols =
      await fetchEquivalentUCJKIdeographs();

  equivalentSymbols['｜'] = '丨';
  equivalentSymbols['ノ'] = '丿';
  equivalentSymbols['ハ'] = '八';
  equivalentSymbols['丷'] = '八';
  equivalentSymbols['ヨ'] = '彐';

  final Map<String, List<String>> inverseEquivalentSymbols = {};
  for (final entry in equivalentSymbols.entries) {
    if (inverseEquivalentSymbols.containsKey(entry.value)) {
      inverseEquivalentSymbols[entry.value]!.add(entry.key);
      continue;
    }
    inverseEquivalentSymbols[entry.value] = [entry.key];
  }

  final response = await http.get(Uri.parse('https://jisho.org/'));
  final document = parse(response.body);
  final table = document.querySelector('.radical_table')!;

  final List<Radical> radicals = [];
  int i = 0;
  for (final node in table.children) {
    if (node.className == 'reset_icon_list_item') continue;
    if (node.className == 'number') {
      i = int.parse(node.innerHtml);
      continue;
    }

    final String radical = node.innerHtml;

    // print(radical);

    KanjiResult? result;
    for (final item in [
      radical,
      equivalentSymbols[radical],
      ...inverseEquivalentSymbols[radical] ?? [],
    ]) {
      if (item == null) continue;
      result = await searchForKanji(item);
      if (result.found) break;
    }

    final Radical radicalData = Radical(
      id: int.parse(node.attributes['data-radical']!),
      symbol: radical,
      strokes: i,
      search_symbol: node.attributes['data-radk'],
      meaning: ['ユ', 'マ'].contains(radical)
          ? 'katakana, jisho search radical'
          : result!.data!.radical!.meaning,
    );

    radicals.add(radicalData);

    print(radicalData.sql_insert);
  }

  assert(radicals.length == 252, '[ERROR] Missing radicals!');
}
