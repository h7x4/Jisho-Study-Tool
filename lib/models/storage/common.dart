import 'package:objectbox/objectbox.dart';
import 'package:unofficial_jisho_api/api.dart' as jisho;

@Entity()
class ExampleSentencePiece {
  int id = 0;
  String? lifted;
  String unlifted;

  ExampleSentencePiece.fromJishoObject(jisho.ExampleSentencePiece object) :
  lifted = object.lifted,
  unlifted = object.unlifted;
}
