import 'package:unofficial_jisho_api/api.dart';

extension GradeConversion on KanjiResultData {
  String? get grade => {
        'grade 1': '小1',
        'grade 2': '小2',
        'grade 3': '小3',
        'grade 4': '小4',
        'grade 5': '小5',
        'grade 6': '小6',
        'junior high': '中'
      }[taughtIn];

  int? get gradeNum => {
        'grade 1': 1,
        'grade 2': 2,
        'grade 3': 3,
        'grade 4': 4,
        'grade 5': 5,
        'grade 6': 6,
        'junior high': 7,
      }[taughtIn];
}
