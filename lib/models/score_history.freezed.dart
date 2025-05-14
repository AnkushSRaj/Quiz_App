// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'score_history.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

ScoreHistory _$ScoreHistoryFromJson(Map<String, dynamic> json) {
  return _ScoreHistory.fromJson(json);
}

/// @nodoc
mixin _$ScoreHistory {
  DateTime get date => throw _privateConstructorUsedError;
  int get score => throw _privateConstructorUsedError;
  int get totalQuestions => throw _privateConstructorUsedError;
  List<String?> get answers => throw _privateConstructorUsedError;
  List<QuizQuestion> get questions => throw _privateConstructorUsedError;

  /// Serializes this ScoreHistory to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of ScoreHistory
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $ScoreHistoryCopyWith<ScoreHistory> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ScoreHistoryCopyWith<$Res> {
  factory $ScoreHistoryCopyWith(
          ScoreHistory value, $Res Function(ScoreHistory) then) =
      _$ScoreHistoryCopyWithImpl<$Res, ScoreHistory>;
  @useResult
  $Res call(
      {DateTime date,
      int score,
      int totalQuestions,
      List<String?> answers,
      List<QuizQuestion> questions});
}

/// @nodoc
class _$ScoreHistoryCopyWithImpl<$Res, $Val extends ScoreHistory>
    implements $ScoreHistoryCopyWith<$Res> {
  _$ScoreHistoryCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of ScoreHistory
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? date = null,
    Object? score = null,
    Object? totalQuestions = null,
    Object? answers = null,
    Object? questions = null,
  }) {
    return _then(_value.copyWith(
      date: null == date
          ? _value.date
          : date // ignore: cast_nullable_to_non_nullable
              as DateTime,
      score: null == score
          ? _value.score
          : score // ignore: cast_nullable_to_non_nullable
              as int,
      totalQuestions: null == totalQuestions
          ? _value.totalQuestions
          : totalQuestions // ignore: cast_nullable_to_non_nullable
              as int,
      answers: null == answers
          ? _value.answers
          : answers // ignore: cast_nullable_to_non_nullable
              as List<String?>,
      questions: null == questions
          ? _value.questions
          : questions // ignore: cast_nullable_to_non_nullable
              as List<QuizQuestion>,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$ScoreHistoryImplCopyWith<$Res>
    implements $ScoreHistoryCopyWith<$Res> {
  factory _$$ScoreHistoryImplCopyWith(
          _$ScoreHistoryImpl value, $Res Function(_$ScoreHistoryImpl) then) =
      __$$ScoreHistoryImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {DateTime date,
      int score,
      int totalQuestions,
      List<String?> answers,
      List<QuizQuestion> questions});
}

/// @nodoc
class __$$ScoreHistoryImplCopyWithImpl<$Res>
    extends _$ScoreHistoryCopyWithImpl<$Res, _$ScoreHistoryImpl>
    implements _$$ScoreHistoryImplCopyWith<$Res> {
  __$$ScoreHistoryImplCopyWithImpl(
      _$ScoreHistoryImpl _value, $Res Function(_$ScoreHistoryImpl) _then)
      : super(_value, _then);

  /// Create a copy of ScoreHistory
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? date = null,
    Object? score = null,
    Object? totalQuestions = null,
    Object? answers = null,
    Object? questions = null,
  }) {
    return _then(_$ScoreHistoryImpl(
      date: null == date
          ? _value.date
          : date // ignore: cast_nullable_to_non_nullable
              as DateTime,
      score: null == score
          ? _value.score
          : score // ignore: cast_nullable_to_non_nullable
              as int,
      totalQuestions: null == totalQuestions
          ? _value.totalQuestions
          : totalQuestions // ignore: cast_nullable_to_non_nullable
              as int,
      answers: null == answers
          ? _value._answers
          : answers // ignore: cast_nullable_to_non_nullable
              as List<String?>,
      questions: null == questions
          ? _value._questions
          : questions // ignore: cast_nullable_to_non_nullable
              as List<QuizQuestion>,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$ScoreHistoryImpl implements _ScoreHistory {
  const _$ScoreHistoryImpl(
      {required this.date,
      required this.score,
      required this.totalQuestions,
      required final List<String?> answers,
      required final List<QuizQuestion> questions})
      : _answers = answers,
        _questions = questions;

  factory _$ScoreHistoryImpl.fromJson(Map<String, dynamic> json) =>
      _$$ScoreHistoryImplFromJson(json);

  @override
  final DateTime date;
  @override
  final int score;
  @override
  final int totalQuestions;
  final List<String?> _answers;
  @override
  List<String?> get answers {
    if (_answers is EqualUnmodifiableListView) return _answers;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_answers);
  }

  final List<QuizQuestion> _questions;
  @override
  List<QuizQuestion> get questions {
    if (_questions is EqualUnmodifiableListView) return _questions;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_questions);
  }

  @override
  String toString() {
    return 'ScoreHistory(date: $date, score: $score, totalQuestions: $totalQuestions, answers: $answers, questions: $questions)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ScoreHistoryImpl &&
            (identical(other.date, date) || other.date == date) &&
            (identical(other.score, score) || other.score == score) &&
            (identical(other.totalQuestions, totalQuestions) ||
                other.totalQuestions == totalQuestions) &&
            const DeepCollectionEquality().equals(other._answers, _answers) &&
            const DeepCollectionEquality()
                .equals(other._questions, _questions));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      date,
      score,
      totalQuestions,
      const DeepCollectionEquality().hash(_answers),
      const DeepCollectionEquality().hash(_questions));

  /// Create a copy of ScoreHistory
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ScoreHistoryImplCopyWith<_$ScoreHistoryImpl> get copyWith =>
      __$$ScoreHistoryImplCopyWithImpl<_$ScoreHistoryImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$ScoreHistoryImplToJson(
      this,
    );
  }
}

abstract class _ScoreHistory implements ScoreHistory {
  const factory _ScoreHistory(
      {required final DateTime date,
      required final int score,
      required final int totalQuestions,
      required final List<String?> answers,
      required final List<QuizQuestion> questions}) = _$ScoreHistoryImpl;

  factory _ScoreHistory.fromJson(Map<String, dynamic> json) =
      _$ScoreHistoryImpl.fromJson;

  @override
  DateTime get date;
  @override
  int get score;
  @override
  int get totalQuestions;
  @override
  List<String?> get answers;
  @override
  List<QuizQuestion> get questions;

  /// Create a copy of ScoreHistory
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ScoreHistoryImplCopyWith<_$ScoreHistoryImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

ScoreHistoryList _$ScoreHistoryListFromJson(Map<String, dynamic> json) {
  return _ScoreHistoryList.fromJson(json);
}

/// @nodoc
mixin _$ScoreHistoryList {
  List<ScoreHistory> get scores => throw _privateConstructorUsedError;

  /// Serializes this ScoreHistoryList to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of ScoreHistoryList
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $ScoreHistoryListCopyWith<ScoreHistoryList> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ScoreHistoryListCopyWith<$Res> {
  factory $ScoreHistoryListCopyWith(
          ScoreHistoryList value, $Res Function(ScoreHistoryList) then) =
      _$ScoreHistoryListCopyWithImpl<$Res, ScoreHistoryList>;
  @useResult
  $Res call({List<ScoreHistory> scores});
}

/// @nodoc
class _$ScoreHistoryListCopyWithImpl<$Res, $Val extends ScoreHistoryList>
    implements $ScoreHistoryListCopyWith<$Res> {
  _$ScoreHistoryListCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of ScoreHistoryList
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? scores = null,
  }) {
    return _then(_value.copyWith(
      scores: null == scores
          ? _value.scores
          : scores // ignore: cast_nullable_to_non_nullable
              as List<ScoreHistory>,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$ScoreHistoryListImplCopyWith<$Res>
    implements $ScoreHistoryListCopyWith<$Res> {
  factory _$$ScoreHistoryListImplCopyWith(_$ScoreHistoryListImpl value,
          $Res Function(_$ScoreHistoryListImpl) then) =
      __$$ScoreHistoryListImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({List<ScoreHistory> scores});
}

/// @nodoc
class __$$ScoreHistoryListImplCopyWithImpl<$Res>
    extends _$ScoreHistoryListCopyWithImpl<$Res, _$ScoreHistoryListImpl>
    implements _$$ScoreHistoryListImplCopyWith<$Res> {
  __$$ScoreHistoryListImplCopyWithImpl(_$ScoreHistoryListImpl _value,
      $Res Function(_$ScoreHistoryListImpl) _then)
      : super(_value, _then);

  /// Create a copy of ScoreHistoryList
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? scores = null,
  }) {
    return _then(_$ScoreHistoryListImpl(
      scores: null == scores
          ? _value._scores
          : scores // ignore: cast_nullable_to_non_nullable
              as List<ScoreHistory>,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$ScoreHistoryListImpl implements _ScoreHistoryList {
  const _$ScoreHistoryListImpl({final List<ScoreHistory> scores = const []})
      : _scores = scores;

  factory _$ScoreHistoryListImpl.fromJson(Map<String, dynamic> json) =>
      _$$ScoreHistoryListImplFromJson(json);

  final List<ScoreHistory> _scores;
  @override
  @JsonKey()
  List<ScoreHistory> get scores {
    if (_scores is EqualUnmodifiableListView) return _scores;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_scores);
  }

  @override
  String toString() {
    return 'ScoreHistoryList(scores: $scores)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ScoreHistoryListImpl &&
            const DeepCollectionEquality().equals(other._scores, _scores));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode =>
      Object.hash(runtimeType, const DeepCollectionEquality().hash(_scores));

  /// Create a copy of ScoreHistoryList
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ScoreHistoryListImplCopyWith<_$ScoreHistoryListImpl> get copyWith =>
      __$$ScoreHistoryListImplCopyWithImpl<_$ScoreHistoryListImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$ScoreHistoryListImplToJson(
      this,
    );
  }
}

abstract class _ScoreHistoryList implements ScoreHistoryList {
  const factory _ScoreHistoryList({final List<ScoreHistory> scores}) =
      _$ScoreHistoryListImpl;

  factory _ScoreHistoryList.fromJson(Map<String, dynamic> json) =
      _$ScoreHistoryListImpl.fromJson;

  @override
  List<ScoreHistory> get scores;

  /// Create a copy of ScoreHistoryList
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ScoreHistoryListImplCopyWith<_$ScoreHistoryListImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
