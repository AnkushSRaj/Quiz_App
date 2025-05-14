import 'package:freezed_annotation/freezed_annotation.dart';
import 'quiz_question.dart';

part 'score_history.freezed.dart';
part 'score_history.g.dart';

@freezed
class ScoreHistory with _$ScoreHistory {
  const factory ScoreHistory({
    required DateTime date,
    required int score,
    required int totalQuestions,
    required List<String?> answers,
    required List<QuizQuestion> questions,
  }) = _ScoreHistory;

  factory ScoreHistory.fromJson(Map<String, dynamic> json) =>
      _$ScoreHistoryFromJson(json);
}

@freezed
class ScoreHistoryList with _$ScoreHistoryList {
  const factory ScoreHistoryList({
    @Default([]) List<ScoreHistory> scores,
  }) = _ScoreHistoryList;

  factory ScoreHistoryList.fromJson(Map<String, dynamic> json) =>
      _$ScoreHistoryListFromJson(json);
}
