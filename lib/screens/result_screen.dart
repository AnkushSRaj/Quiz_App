import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../providers/quiz_provider.dart';
import '../providers/score_provider.dart';
import '../models/score_history.dart';
import '../models/quiz_question.dart';
import 'home_screen.dart';
import 'quiz_screen.dart';
import 'package:flutter/foundation.dart';

class ResultScreen extends ConsumerStatefulWidget {
  final ScoreHistory? historyScore;

  const ResultScreen({
    super.key,
    this.historyScore,
  });

  @override
  ConsumerState<ResultScreen> createState() => _ResultScreenState();
}

class _ResultScreenState extends ConsumerState<ResultScreen> {
  @override
  void initState() {
    super.initState();
    if (widget.historyScore == null) {
      _saveScore();
    }
  }

  Future<void> _saveScore() async {
    try {
      final quizState = ref.read(quizStateProvider);
      final quizAsync = ref.read(quizNotifierProvider);

      if (quizAsync is! AsyncData) {
        if (kDebugMode) {
          print('Quiz data is not available');
        }
        return;
      }

      final questions = quizAsync.value;
      if (questions == null) {
        if (kDebugMode) {
          print('Questions are null');
        }
        return;
      }

      if (kDebugMode) {
        print('Saving score with ${questions.length} questions');
        print('User answers: ${quizState.answers}');
      }

      final score = ScoreHistory(
        date: DateTime.now(),
        score: quizState.score,
        totalQuestions: questions.length,
        answers: quizState.answers,
        questions: questions,
      );

      await ref.read(scoreHistoryNotifierProvider.notifier).addScore(score);

      if (kDebugMode) {
        print('Score saved successfully');
      }
    } catch (e, stackTrace) {
      if (kDebugMode) {
        print('Error saving score: $e');
        print('Stack trace: $stackTrace');
      }
    }
  }

  Widget _buildQuizResults(
      List<QuizQuestion> questions, List<String?> answers) {
    return ListView.builder(
      itemCount: questions.length,
      itemBuilder: (context, index) {
        final question = questions[index];
        final userAnswer = answers[index];
        final isCorrect = userAnswer == question.correctAnswer;

        return Card(
          margin: const EdgeInsets.only(bottom: 16),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
            side: BorderSide(
              color: isCorrect ? Colors.green : Colors.red,
              width: 2,
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Icon(
                      isCorrect ? Icons.check_circle : Icons.cancel,
                      color: isCorrect ? Colors.green : Colors.red,
                    ),
                    const SizedBox(width: 8),
                    Text(
                      isCorrect ? 'Correct' : 'Incorrect',
                      style: TextStyle(
                        color: isCorrect ? Colors.green : Colors.red,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 12),
                Text(
                  question.question,
                  style: Theme.of(context).textTheme.titleMedium,
                ),
                const SizedBox(height: 8),
                Text(
                  'Your answer: $userAnswer',
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
                if (!isCorrect) ...[
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      const Icon(
                        Icons.lightbulb_outline,
                        color: Colors.amber,
                        size: 20,
                      ),
                      const SizedBox(width: 8),
                      Text(
                        'Correct answer: ${question.correctAnswer}',
                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                              color: Colors.green,
                              fontWeight: FontWeight.bold,
                            ),
                      ),
                    ],
                  ),
                ],
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildHistoryTab(AsyncValue<List<ScoreHistory>> scoreHistoryAsync) {
    return scoreHistoryAsync.when(
      loading: () => const Center(
        child: CircularProgressIndicator(),
      ),
      error: (error, stackTrace) => Center(
        child: Text('Error: $error'),
      ),
      data: (scores) {
        if (scores.isEmpty) {
          return const Center(
            child: Text('No previous scores'),
          );
        }
        return ListView.builder(
          itemCount: scores.length,
          itemBuilder: (context, index) {
            final score = scores[index];
            return Card(
              margin: const EdgeInsets.only(bottom: 16),
              child: InkWell(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => ResultScreen(
                        historyScore: score,
                      ),
                    ),
                  );
                },
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Score: ${score.score}/${score.totalQuestions}',
                            style: Theme.of(context).textTheme.titleMedium,
                          ),
                          Text(
                            '${(score.score / score.totalQuestions * 100).toStringAsFixed(1)}%',
                            style: Theme.of(context)
                                .textTheme
                                .titleMedium
                                ?.copyWith(
                                  color: Theme.of(context).colorScheme.primary,
                                ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 8),
                      Text(
                        'Date: ${score.date.toString().split('.')[0]}',
                        style: Theme.of(context).textTheme.bodyMedium,
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        );
      },
    );
  }

  Widget _buildActionButtons(BuildContext context,
      {bool isHistoryView = false}) {
    return Row(
      children: [
        if (isHistoryView) ...[
          Expanded(
            child: ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.white,
                foregroundColor: Theme.of(context).colorScheme.primary,
                side: BorderSide(
                  color: Theme.of(context).colorScheme.primary,
                ),
              ),
              child: const Text('Back'),
            ),
          ),
          const SizedBox(width: 16),
        ],
        Expanded(
          child: ElevatedButton(
            onPressed: () async {
              if (isHistoryView) {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const HomeScreen(),
                  ),
                );
              } else {
                await ref.read(quizStateProvider.notifier).resetQuiz();
                if (mounted) {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const QuizScreen(),
                    ),
                  );
                }
              }
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: isHistoryView
                  ? Theme.of(context).colorScheme.primary
                  : Colors.white,
              foregroundColor: isHistoryView
                  ? Colors.white
                  : Theme.of(context).colorScheme.primary,
              side: BorderSide(
                color: Theme.of(context).colorScheme.primary,
              ),
            ),
            child: Text(isHistoryView ? 'Home' : 'Try Again'),
          ),
        ),
        if (!isHistoryView) ...[
          const SizedBox(width: 16),
          Expanded(
            child: ElevatedButton(
              onPressed: () {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const HomeScreen(),
                  ),
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Theme.of(context).colorScheme.primary,
                foregroundColor: Colors.white,
              ),
              child: const Text('Home'),
            ),
          ),
        ],
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    final quizState = ref.watch(quizStateProvider);
    final quizAsync = ref.watch(quizNotifierProvider);
    final scoreHistoryAsync = ref.watch(scoreHistoryNotifierProvider);

    if (widget.historyScore != null) {
      return Scaffold(
        appBar: AppBar(
          title: const Text('Quiz Results'),
          automaticallyImplyLeading: false,
        ),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Container(
                padding: const EdgeInsets.all(24),
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.primary,
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Column(
                  children: [
                    Text(
                      'Quiz Results',
                      style:
                          Theme.of(context).textTheme.headlineMedium?.copyWith(
                                color: Colors.white,
                              ),
                    ),
                    const SizedBox(height: 16),
                    Text(
                      'Score: ${widget.historyScore!.score}/${widget.historyScore!.totalQuestions}',
                      style:
                          Theme.of(context).textTheme.headlineSmall?.copyWith(
                                color: Colors.white,
                              ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      '${(widget.historyScore!.score / widget.historyScore!.totalQuestions * 100).toStringAsFixed(1)}%',
                      style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                            color: Colors.white,
                          ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'Date: ${widget.historyScore!.date.toString().split('.')[0]}',
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                            color: Colors.white,
                          ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 24),
              Expanded(
                child: _buildQuizResults(
                  widget.historyScore!.questions,
                  widget.historyScore!.answers,
                ),
              ),
              const SizedBox(height: 16),
              _buildActionButtons(context, isHistoryView: true),
            ],
          ),
        ),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('Quiz Results'),
        automaticallyImplyLeading: false,
      ),
      body: quizAsync.when(
        loading: () => const Center(
          child: CircularProgressIndicator(),
        ),
        error: (error, stackTrace) => Center(
          child: Text('Error: $error'),
        ),
        data: (questions) {
          return Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Container(
                  padding: const EdgeInsets.all(24),
                  decoration: BoxDecoration(
                    color: Theme.of(context).colorScheme.primary,
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Column(
                    children: [
                      Text(
                        'Quiz Complete!',
                        style: Theme.of(context)
                            .textTheme
                            .headlineMedium
                            ?.copyWith(
                              color: Colors.white,
                            ),
                      ),
                      const SizedBox(height: 16),
                      Text(
                        'Your Score: ${quizState.score}/${questions.length}',
                        style:
                            Theme.of(context).textTheme.headlineSmall?.copyWith(
                                  color: Colors.white,
                                ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        '${(quizState.score / questions.length * 100).toStringAsFixed(1)}%',
                        style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                              color: Colors.white,
                            ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 24),
                Expanded(
                  child: DefaultTabController(
                    length: 2,
                    child: Column(
                      children: [
                        TabBar(
                          tabs: const [
                            Tab(text: 'Current Quiz'),
                            Tab(text: 'History'),
                          ],
                          labelColor: Theme.of(context).colorScheme.primary,
                          unselectedLabelColor: Colors.grey,
                        ),
                        Expanded(
                          child: TabBarView(
                            children: [
                              _buildQuizResults(questions, quizState.answers),
                              _buildHistoryTab(scoreHistoryAsync),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 16),
                _buildActionButtons(context),
              ],
            ),
          );
        },
      ),
    );
  }
}
