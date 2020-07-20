final kanjiPattern = RegExp(r'[\x3400-\x4DB5\x4E00-\x9FCB\xF900-\xFA6A]');

List<String> kanjiSuggestions(String string) {
  return kanjiPattern.allMatches(string).map((match) => match.group(0));
}