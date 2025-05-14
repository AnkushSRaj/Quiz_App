// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'score_history.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$ScoreHistoryImpl _$$ScoreHistoryImplFromJson(Map<String, dynamic> json) =>
    _$ScoreHistoryImpl(
      date: DateTime.parse(json['date'] as String),
      score: (json['score'] as num).toInt(),
      totalQuestions: (json['totalQuestions'] as num).toInt(),
      answers:
          (json['answers'] as List<dynamic>).map((e) => e as String?).toList(),
      questions: (json['questions'] as List<dynamic>)
          .map((e) => QuizQuestion.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$$ScoreHistoryImplToJson(_$ScoreHistoryImpl instance) =>
    <String, dynamic>{
      'date': instance.date.toIso8601String(),
      'score': instance.score,
      'totalQuestions': instance.totalQuestions,
      'answers': instance.answers,
      'questions': instance.questions,
    };

_$ScoreHistoryListImpl _$$ScoreHistoryListImplFromJson(
        Map<String, dynamic> json) =>
    _$ScoreHistoryListImpl(
      scores: (json['scores'] as List<dynamic>?)
              ?.map((e) => ScoreHistory.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
    );

Map<String, dynamic> _$$ScoreHistoryListImplToJson(
        _$ScoreHistoryListImpl instance) =>
    <String, dynamic>{
      'scores': instance.scores,
    };
