import 'dart:io';

// Example file Structure:
//   jisho_data_22.01.01_1
//   - history.json
//   - library/
//     - lista.json
//     - listb.json

extension ArchiveFormat on Directory {
  // TODO: make the export dir dependent on date
  Directory get exportDirectory {
    final dir = Directory(uri.resolve('export').path);
    dir.createSync(recursive: true);
    return dir;
  }

  File get historyFile => File(uri.resolve('history.json').path);
  Directory get libraryDir => Directory(uri.resolve('library').path);
}
