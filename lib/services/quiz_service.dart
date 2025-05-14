import 'package:dio/dio.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'dart:convert';
import 'dart:developer' as developer;
import '../models/quiz_question.dart';
import '../providers/quiz_provider.dart';

part 'quiz_service.g.dart';

class QuizService {
  final Dio _dio;
  static const String _apiKey =
      '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';
  static const String _baseUrl =
      'https://api.groq.com/openai/v1/chat/completions';

  QuizService() : _dio = Dio() {
    developer.log('Initializing QuizService');
    _dio.interceptors.add(LogInterceptor(
      requestBody: true,
      responseBody: true,
      logPrint: (object) => developer.log(object.toString()),
    ));
  }

  Future<List<QuizQuestion>> generateQuizQuestions(
      {required QuizDifficulty difficulty}) async {
    developer
        .log('Starting quiz question generation with difficulty: $difficulty');

    final timestamp = DateTime.now().millisecondsSinceEpoch;
    final prompt = '''
Generate 5 unique and diverse multiple-choice questions on general knowledge.
Difficulty level: ${difficulty.displayName}

For ${difficulty.displayName} difficulty:
${_getDifficultyInstructions(difficulty)}

Each question should have:
- A clear and concise question
- 4 distinct options
- The correct answer clearly marked

Return only valid JSON in this format:
{
  "questions": [
    {
      "question": "string",
      "options": ["string", "string", "string", "string"],
      "correctAnswer": "string"
    }
  ]
}

Make sure the questions are unique and not commonly found in standard quizzes.
Timestamp: $timestamp
''';

    try {
      developer.log('Sending API request with data: ${jsonEncode({
            'model': 'llama-3.3-70b-versatile',
            'messages': [
              {
                'role': 'system',
                'content':
                    'You are a quiz generator. Generate unique and diverse questions in valid JSON format.'
              },
              {'role': 'user', 'content': prompt}
            ],
            'temperature': 0.9,
            'response_format': {'type': 'json_object'},
            'max_completion_tokens': 1000
          })}');

      final response = await _dio.post(
        _baseUrl,
        options: Options(
          headers: {
            'Authorization': 'Bearer $_apiKey',
            'Content-Type': 'application/json',
          },
        ),
        data: {
          'model': 'llama-3.3-70b-versatile',
          'messages': [
            {
              'role': 'system',
              'content':
                  'You are a quiz generator. Generate unique and diverse questions in valid JSON format.'
            },
            {'role': 'user', 'content': prompt}
          ],
          'temperature': 0.9,
          'response_format': {'type': 'json_object'},
          'max_completion_tokens': 1000
        },
      );

      developer.log('API Response Status: ${response.statusCode}');
      developer.log('API Response Data: ${response.data}');

      if (response.statusCode == 200) {
        final responseData = response.data;
        developer.log('Received API response: ${response.statusCode}');
        developer.log('Response data: $responseData');

        if (responseData['choices'] != null &&
            responseData['choices'].isNotEmpty &&
            responseData['choices'][0]['message'] != null) {
          final content = responseData['choices'][0]['message']['content'];
          developer.log('Parsing API content: $content');

          try {
            final Map<String, dynamic> jsonResponse = jsonDecode(content);
            developer.log('Parsed JSON response: $jsonResponse');

            if (jsonResponse['questions'] != null) {
              final List<dynamic> questionsJson = jsonResponse['questions'];
              developer.log('Validating ${questionsJson.length} questions');

              final questions = questionsJson.map((q) {
                return QuizQuestion(
                  question: q['question'],
                  options: List<String>.from(q['options']),
                  correctAnswer: q['correctAnswer'],
                );
              }).toList();

              if (questions.length == 5) {
                developer.log(
                    'Successfully generated ${questions.length} questions');
                return questions;
              }
            }
          } catch (e) {
            developer.log('Error parsing JSON: $e');
            throw Exception('Failed to parse quiz questions: $e');
          }
        }
        throw Exception('Invalid response format from API');
      } else {
        throw Exception(
            'Failed to generate quiz questions: ${response.statusCode}');
      }
    } on DioException catch (e) {
      developer.log('DioException: ${e.message}');
      developer.log('Error type: ${e.type}');
      developer.log('Error response: ${e.response?.data}');
      throw Exception('Network error: ${e.message}');
    } catch (e) {
      developer.log('Error generating quiz: $e');
      throw Exception('Failed to generate quiz questions: $e');
    }
  }

  String _getDifficultyInstructions(QuizDifficulty difficulty) {
    switch (difficulty) {
      case QuizDifficulty.easy:
        return '''
- Use simple, straightforward questions
- Focus on common knowledge and basic facts
- Make the correct answer more obvious
- Use familiar topics and concepts''';
      case QuizDifficulty.medium:
        return '''
- Use moderately challenging questions
- Include some specific knowledge
- Make the options more balanced
- Mix common and less common topics''';
      case QuizDifficulty.hard:
        return '''
- Use complex and challenging questions
- Include specific and detailed knowledge
- Make all options plausible
- Focus on less common topics and concepts''';
    }
  }
}

@riverpod
QuizService quizService(ref) {
  print('Creating QuizService provider');
  return QuizService();
}
