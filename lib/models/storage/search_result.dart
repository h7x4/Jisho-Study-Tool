// import 'package:objectbox/objectbox.dart';
// import 'package:unofficial_jisho_api/api.dart' as jisho;

// @Entity()
// class SearchResult {
//   int id = 0;
//   final meta = ToOne<JishoResultMeta>();
//   final data = ToMany<JishoResult>();

//   // SearchResult(JishoAPIResult result) {
//   //   this.data = result.data;
//   //   this.meta = result.meta;
//   // }

//   // JishoAPIResult toJishoAPIResult() {
//   //   return JishoAPIResult(meta: this.meta, data: this.data);
//   // }
// }

// @Entity()
// class JishoResultMeta {
//   int id = 0;
//   int status;
// }

// @Entity()
// class JishoResult {
//   int id = 0;
//   final attribution = ToOne<JishoAttribution>();
//   bool is_common;
//   final japanese = ToMany<JishoJapaneseWord>();
//   List<String> jlpt;
//   final senses = ToMany<JishoWordSense>();
//   String slug;
//   List<String> tags;
// }

// @Entity()
// class JishoAttribution {
//   int id = 0;
//   String dbpedia;
//   String jmdict;
//   bool jmnedict;
// }

// @Entity()
// class JishoJapaneseWord {
//   int id = 0;
//   String reading;
//   String word;
// }

// @Entity()
// class JishoWordSense {
//   int id = 0;
//   List<String> antonyms;
//   List<String> english_definitions;
//   List<String> info;
//   final links = ToMany<JishoSenseLink>();
//   List<String> parts_of_speech;
//   List<String> restrictions;
//   List<String> see_also;
//   List<dynamic> source;
//   List<String> tags;
// }

// @Entity()
// class JishoSenseLink {
//   int id = 0;
//   String text;
//   String url;
// }
