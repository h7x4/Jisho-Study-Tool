import 'dart:io';
import 'dart:math';

// Example file Structure:
//   jisho_data_2022.01.01_1
//   - history.json
//   - library/
//     - lista.json
//     - listb.json

extension ArchiveFormat on Directory {
  Directory get exportDirectory {
    final dir = Directory(uri.resolve('export').path);
    dir.createSync(recursive: true);

    final DateTime today = DateTime.now();
    final String formattedDate = '${today.year}'
        '.${today.month.toString().padLeft(2, '0')}'
        '.${today.day.toString().padLeft(2, '0')}';

    final List<int> takenNumbers = dir
        .listSync()
        .map((f) => f.uri.pathSegments[f.uri.pathSegments.length - 2])
        .where((p) => RegExp('^jisho_data_${formattedDate}_(\\d+)').hasMatch(p))
        .map((p) => int.tryParse(p.substring('jisho_data_0000.00.00_'.length)))
        .whereType<int>()
        .toList();

    final int nextNum = takenNumbers.fold(0, max) + 1;

    return Directory(
      dir.uri.resolve('jisho_data_${formattedDate}_$nextNum').path,
    )..createSync();
  }

  File get historyFile => File(uri.resolve('history.json').path);
  Directory get libraryDir => Directory(uri.resolve('library').path);
}
