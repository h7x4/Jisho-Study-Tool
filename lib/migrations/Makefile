DB_NAME=test.db

all: clean dart
	sqlite3 $(DB_NAME) < 0001_initial.sql
	sqlite3 $(DB_NAME) < 0002_populate_radicals.sql
	sqlite3 $(DB_NAME) < 0003_populate_radkfile.sql
	sqlite3 $(DB_NAME) < 0004_populate_jouyou_kanji.sql

convert_kradk:
	iconv -f EUC-JP -t UTF-8 -o data/radkfile_utf8 data/radkfile

dart:
	dart run tools/update_0002.dart
	dart run tools/update_0003.dart
	dart run tools/update_0004.dart

clean:
	rm test.db || true
