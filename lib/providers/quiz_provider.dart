import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/quiz_question.dart';
import '../services/quiz_service.dart';
import 'dart:async';
import 'package:flutter/material.dart';
import '../screens/result_screen.dart';

enum QuizDifficulty {
  easy,
  medium,
  hard;

  String get displayName {
    switch (this) {
      case QuizDifficulty.easy:
        return 'Easy';
      case QuizDifficulty.medium:
        return 'Medium';
      case QuizDifficulty.hard:
        return 'Hard';
    }
  }
}

class QuizStateData {
  final int currentQuestionIndex;
  final int score;
  final bool isAnswered;
  final String? selectedAnswer;
  final List<String?> answers;
  final int timeRemaining;
  final Timer? timer;

  QuizStateData({
    required this.currentQuestionIndex,
    required this.score,
    required this.isAnswered,
    required this.selectedAnswer,
    required this.answers,
    required this.timeRemaining,
    this.timer,
  });

  QuizStateData copyWith({
    int? currentQuestionIndex,
    int? score,
    bool? isAnswered,
    String? selectedAnswer,
    List<String?>? answers,
    int? timeRemaining,
    Timer? timer,
  }) {
    return QuizStateData(
      currentQuestionIndex: currentQuestionIndex ?? this.currentQuestionIndex,
      score: score ?? this.score,
      isAnswered: isAnswered ?? this.isAnswered,
      selectedAnswer: selectedAnswer ?? this.selectedAnswer,
      answers: answers ?? this.answers,
      timeRemaining: timeRemaining ?? this.timeRemaining,
      timer: timer ?? this.timer,
    );
  }

  @override
  String toString() {
    return 'QuizStateData(currentQuestionIndex: $currentQuestionIndex, score: $score, isAnswered: $isAnswered, selectedAnswer: $selectedAnswer, answers: $answers, timeRemaining: $timeRemaining)';
  }
}

class QuizNotifier extends StateNotifier<AsyncValue<List<QuizQuestion>>> {
  final QuizService _quizService;
  final Ref ref;
  bool _isGenerating = false;

  QuizNotifier(this._quizService, this.ref)
      : super(const AsyncValue.loading()) {
    generateNewQuiz();

    ref.listen(quizDifficultyProvider, (previous, next) {
      if (previous != next) {
        generateNewQuiz();
      }
    });
  }

  Future<void> generateNewQuiz() async {
    if (_isGenerating) return;
    _isGenerating = true;

    try {
      state = const AsyncValue.loading();
      final difficulty = ref.read(quizDifficultyProvider);
      final questions =
          await _quizService.generateQuizQuestions(difficulty: difficulty);
      state = AsyncValue.data(questions);
    } catch (e, stackTrace) {
      state = AsyncValue.error(e, stackTrace);
    } finally {
      _isGenerating = false;
    }
  }

  Future<void> resetQuiz() async {
    state = const AsyncValue.loading();
    await generateNewQuiz();
  }
}

class QuizStateNotifier extends StateNotifier<QuizStateData> {
  final Ref ref;
  static const int questionTimeLimit = 45;

  QuizStateNotifier(this.ref)
      : super(QuizStateData(
          currentQuestionIndex: 0,
          score: 0,
          isAnswered: false,
          selectedAnswer: null,
          answers: [],
          timeRemaining: questionTimeLimit,
        )) {
    _startTimer();
  }

  void _startTimer() {
    state.timer?.cancel();
    final timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (state.timeRemaining > 0 && !state.isAnswered) {
        state = state.copyWith(timeRemaining: state.timeRemaining - 1);
      } else if (state.timeRemaining == 0 && !state.isAnswered) {
        _handleTimeUp();
      }
    });
    state = state.copyWith(timer: timer);
  }

  void _handleTimeUp() {
    final questionsAsync = ref.read(quizNotifierProvider);
    if (questionsAsync is! AsyncData) return;

    final questions = questionsAsync.value;
    if (questions == null) return;

    final newAnswers = List<String?>.from(state.answers);
    while (newAnswers.length <= state.currentQuestionIndex) {
      newAnswers.add(null);
    }
    newAnswers[state.currentQuestionIndex] = null;

    state = state.copyWith(
      isAnswered: true,
      selectedAnswer: null,
      answers: newAnswers,
    );

    if (state.currentQuestionIndex == questions.length - 1) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        final context = ref.read(navigatorKeyProvider).currentContext;
        if (context != null) {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => const ResultScreen(),
            ),
          );
        }
      });
    } else {
      Future.delayed(const Duration(seconds: 1), () {
        nextQuestion();
      });
    }
  }

  void answerQuestion(String answer) {
    if (state.isAnswered) return;

    final questionsAsync = ref.read(quizNotifierProvider);
    if (questionsAsync is! AsyncData) return;

    final questions = questionsAsync.value;
    if (questions == null) return;

    final currentQuestion = questions[state.currentQuestionIndex];
    final isCorrect = answer == currentQuestion.correctAnswer;
    final newScore = isCorrect ? state.score + 1 : state.score;

    final newAnswers = List<String?>.from(state.answers);
    while (newAnswers.length <= state.currentQuestionIndex) {
      newAnswers.add(null);
    }
    newAnswers[state.currentQuestionIndex] = answer;

    state = state.copyWith(
      score: newScore,
      isAnswered: true,
      selectedAnswer: answer,
      answers: newAnswers,
    );
  }

  void nextQuestion() {
    state = state.copyWith(
      currentQuestionIndex: state.currentQuestionIndex + 1,
      isAnswered: false,
      selectedAnswer: null,
      timeRemaining: questionTimeLimit,
    );
    _startTimer();
  }

  Future<void> resetQuiz() async {
    state.timer?.cancel();
    await ref.read(quizNotifierProvider.notifier).resetQuiz();
    state = QuizStateData(
      currentQuestionIndex: 0,
      score: 0,
      isAnswered: false,
      selectedAnswer: null,
      answers: [],
      timeRemaining: questionTimeLimit,
    );
    _startTimer();
  }

  @override
  void dispose() {
    state.timer?.cancel();
    super.dispose();
  }
}

final quizServiceProvider = Provider<QuizService>((ref) {
  return QuizService();
});

final quizNotifierProvider =
    StateNotifierProvider<QuizNotifier, AsyncValue<List<QuizQuestion>>>((ref) {
  final quizService = ref.watch(quizServiceProvider);
  return QuizNotifier(quizService, ref);
});

final quizStateProvider =
    StateNotifierProvider<QuizStateNotifier, QuizStateData>((ref) {
  return QuizStateNotifier(ref);
});

final quizDifficultyProvider =
    StateProvider<QuizDifficulty>((ref) => QuizDifficulty.medium);

final navigatorKeyProvider = Provider<GlobalKey<NavigatorState>>((ref) {
  return GlobalKey<NavigatorState>();
});
