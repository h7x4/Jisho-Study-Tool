import 'dart:io';

// TODO: Automate download of radkfile

void main() {
  final String content = File('data/radkfile_utf8').readAsStringSync();
  final Iterable<String> blocks =
      content.replaceAll(RegExp(r'^#.*$'), '').split(r'$').skip(2);

  final List<String> tuples = [];
  for (final block in blocks) {
    final String radical = block[1];
    final List<String> kanjiList = block
        .replaceFirst(RegExp(r'.*\n'), '')
        .split('')
      ..removeWhere((e) => e == '' || e == '\n');

    for (final kanji in kanjiList) {
      tuples.add("  ('$radical', '$kanji')");
    }
  }

  File('0003_populate_radkfile.sql').writeAsStringSync(
    '''
INSERT INTO RADKFILE(radical, kanji) VALUES
${tuples.join(',\n')};''',
  );
}
