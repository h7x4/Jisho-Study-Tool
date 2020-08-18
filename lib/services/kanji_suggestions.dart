final kanjiPattern = RegExp(r'[\u3400-\u4DB5\u4E00-\u9FCB\uF900-\uFA6A]');

List<String> kanjiSuggestions(String string) {
  return kanjiPattern.allMatches(string).map((match) => match.group(0)).toList();
}