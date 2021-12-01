import 'package:objectbox/objectbox.dart';
import 'package:unofficial_jisho_api/api.dart' as jisho;

import 'common.dart';

@Entity()
class PhraseScrapeSentence {
  int id = 0;
  String english;
  String japanese;
  List<ExampleSentencePiece> pieces;

  PhraseScrapeSentence.fromJishoObject(jisho.PhraseScrapeSentence object)
      : english = object.english,
        japanese = object.japanese,
        pieces = object.pieces
            .map((p) => ExampleSentencePiece.fromJishoObject(p))
            .toList();
}

@Entity()
class PhraseScrapeMeaning {
  int id = 0;
  List<String> seeAlsoTerms;
  List<PhraseScrapeSentence> sentences;
  String definition;
  List<String> supplemental;
  String? definitionAbstract;
  List<String> tags;

  PhraseScrapeMeaning.fromJishoObject(jisho.PhraseScrapeMeaning object)
      : seeAlsoTerms = object.seeAlsoTerms,
        sentences = object.sentences
            .map((s) => PhraseScrapeSentence.fromJishoObject(s))
            .toList(),
        definition = object.definition,
        supplemental = object.supplemental,
        definitionAbstract = object.definitionAbstract,
        tags = object.tags;
}

@Entity()
class KanjiKanaPair {
  int id = 0;
  String kanji;
  String? kana;

  KanjiKanaPair.fromJishoObject(jisho.KanjiKanaPair object)
      : kanji = object.kanji,
        kana = object.kana;
}

@Entity()
class PhrasePageScrapeResult {
  int id = 0;
  bool found;
  String query;
  PhrasePageScrapeResultData? data;

  PhrasePageScrapeResult.fromJishoObject(jisho.PhrasePageScrapeResult object)
      : found = object.found,
        query = object.query,
        data = (object.data == null)
            ? null
            : PhrasePageScrapeResultData.fromJishoObject(object.data!);
}

@Entity()
class AudioFile {
  int id = 0;
  String uri;
  String mimetype;

  AudioFile.fromJishoObject(jisho.AudioFile object)
      : uri = object.uri,
        mimetype = object.mimetype;
}

@Entity()
class PhrasePageScrapeResultData {
  int id = 0;
  String uri;
  List<String> tags;
  List<PhraseScrapeMeaning> meanings;
  List<KanjiKanaPair> otherForms;
  List<AudioFile> audio;
  List<String> notes;

  PhrasePageScrapeResultData.fromJishoObject(
    jisho.PhrasePageScrapeResultData object,
  )   : uri = object.uri,
        tags = object.tags,
        meanings = object.meanings
            .map((m) => PhraseScrapeMeaning.fromJishoObject(m))
            .toList(),
        otherForms = object.otherForms
            .map((f) => KanjiKanaPair.fromJishoObject(f))
            .toList(),
        audio = object.audio.map((a) => AudioFile.fromJishoObject(a)).toList(),
        notes = object.notes;
}
